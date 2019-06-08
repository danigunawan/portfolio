class User < ActiveRecord::Base
	before_save :set_username

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable,
		:confirmable, :authentication_keys => [:username]
	alias :devise_valid_password? :valid_password?

	# REENABLE AFTER MIGRATIONS
	after_validation :start_subscription
	after_save :enforce_billing, :sync_with_stripe_later

	belongs_to :site

	geocoded_by :last_sign_in_ip       # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	# Commontator gem actor
	acts_as_commentable

	# For seller ratings and reviews
	acts_as_votable

	acts_as_messageable

	# Soft delete override
	acts_as_paranoid

	has_paper_trail

	def mailboxer_email(messageable)
	  email
	end

	def notify
		true
	end

	# ---------------------------------------------
	# Auth login methods.
	# ---------------------------------------------

	# Virtual attribute for authenticating by either username or email
	# This is in addition to a real persisted field like 'username'
	validates :username,
		presence: true,
		uniqueness: {
			case_sensitive: false
		}

	validates :site, presence: true

	validates :first_name, presence: true
	validates :last_name, presence: true

	validates :email,
		uniqueness: false,
		presence: true

	def set_username
		if site && email
			username = User.format_username_with_site(email, site)
			write_attribute(:username, User.format_username_with_site(email, site))
		end
	end

	# Disable devises default email fields and use rails vanilla instead.
	def email_required?
		false
	end

	def email_changed?
		false
	end

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_hash).where(["lower(username) = :value", { :value => login.downcase }]).first
		elsif conditions.has_key?(:username)
			where(conditions.to_hash).first
		end
	end

	def self.format_username_with_site(email, site)
		"[#{ site ? site.id : 'NULL' }]#{ email }"
	end

	# Updates the user's last location.
	def update_user_location_from_request(request)
		# Track user's last know location and ip address.
		# locations.create(ip_address:request.location.ip).geocode if locations.last and locations.last.ip_address != request.location.ip
	end

	def valid_password?(password)
		begin
			super(password)
		rescue BCrypt::Errors::InvalidHash
			return false unless Digest::SHA1.hexdigest(password) == encrypted_password
			logger.info "User #{email} is using the old password hashing method, updating attribute."
			self.password = password
			true
		end
	end

	# ---------------------------------------------
	# Listing references to explicit listing objects
	# ---------------------------------------------

	has_many :listings, -> { without_deleted }
	has_many :posts, -> { without_deleted }
	has_many :listing_drafts
	has_many :listing_messages
	has_many :favorites, -> { without_deleted }
	has_many :saved_searches, -> { without_deleted }
	has_many :photos
	has_many :support_tickets
	has_one :business

	def update_location_from_request(request)
	end

	def is_admin?
		return false if !self.email
		self.admin
	end

	def is_super_admin?
		self.is_admin?
	end

	# =========================================
	# Billing Verifications & Enforcement
	# =========================================

	def valid_listings
		listings.order(created_at: :asc).limit(plan.listings)
	end

	def invalid_listings
		listings - valid_listings
	end

	# Billing verification helper. Will set any necessary blocks on listings that are un-paid.
	def enforce_billing
		# self.trial_expires_at = Time.at(self.subscription.trial_end) if !self.trial_expires_at
		# self.on_trial = (self.trial_expires_at > Time.now && !self.card_last_4)
		# self.on_trial_grace_period = (self.trial_expires_at < Time.now && (self.trial_expires_at + 3.day) > Time.now && !self.card_last_4)

		# Give a free grace period to upgrade from the free trial.
		# If the trial has expired && no billing info is present cancel the trial.
		# if !self.on_trial_grace_period && !self.on_trial && !self.card_last_4
			# self.plan = Plan.FREE_PLAN
			# start_subscription
		# end

		valid_listings.each do |listing|
			listing.update(billing_active: true) if !listing.billing_active
		end

		invalid_listings.each do |listing|
			listing.update(billing_active: false) if listing.billing_active
		end
	end

	def enforce_billing_and_save
		enforce_billing
		save
	end

	def enforce_billing_and_save_later
		ModelTaskJob.perform_later self, "enforce_billing_and_save"
	end

	# =========================================
	# PLANS
	# =========================================

	belongs_to :plan

	def plan
		# Set the plan and version number.
		self.plan = site.FREE_PLAN if !read_attribute(:plan_id)
		super
	end

	def remaining_listings
		self.plan.listings - listings.count
	end

	def allowed_listings
		self.plan && self.plan.listings && self.plan.listings > listings.count ? self.plan.listings - listings.count : 0
	end

	# =========================================
	# CUSTOMER
	# =========================================
	#
	def full_name
		@full_name = read_attribute(:full_name)
		@full_name ||= [first_name, last_name].select{ |i| !i.blank? }.join(' ')
	end
	alias name full_name

	def first_name
		super.blank? ? super : super.clean_name
	end

	def last_name
		super.blank? ? super : super.clean_name
	end

	def customer_description
		@customer_description ||= [full_name, (email.blank? ? nil : "<#{ email }>"), (is_suspended ? '[SUSPENDED]' : nil)].select{ |i| !i.blank? }.join(' ')
	end

	# Subscription Object Helpers
	def customer_id
		read_attribute(:customer_id)
	end

	def customer_id=(value)
		update_columns(customer_id: value) if self.id
		write_attribute(:customer_id, value)
	end

	# Customer Object Helpers
	def customer(source=nil)
		@customer ||= nil

		begin
			# Retrieve the Stripe object if this is a fetch.
			@customer ||= Stripe::Customer.retrieve(self.customer_id, api_key: site.env['STRIPE_SECRET_KEY']) if self.customer_id
		rescue => e
			# Rescue the customer not found error.
			@customer = nil
		end

		begin
			# Create a customer if none was found or if no customer id is set.
			@customer = Stripe::Customer.create({email: self.email, description: self.customer_description}, {api_key: site.env['STRIPE_SECRET_KEY']}) if !self.customer_id || (@customer && @customer['deleted'])
		rescue => e
			# Rescue the customer not found error.
			@customer = nil
		end

		# Update payment method on account and not create a new customer object.
		if source && (self.customer_id || @customer)
			begin
				@customer.source = source
				@customer.save

				self.card_last_4 = "****" if !self.card_last_4
				if @customer.sources.first
					self.card_last_4 = @customer.sources.first.last4
					self.card_type = @customer.sources.first.brand.downcase
				end
			rescue Stripe::CardError => e

			rescue Stripe::RateLimitError => e
				# Too many requests made to the API too quickly
			rescue Stripe::InvalidRequestError => e
				# Invalid parameters were supplied to Stripe's API
			rescue Stripe::AuthenticationError => e
				# Authentication with Stripe's API failed
				# (maybe you changed API keys recently)
			rescue Stripe::APIConnectionError => e
				# Network communication with Stripe failed
			rescue Stripe::StripeError => e
				# Display a very generic error to the user, and maybe send
				# yourself an email
			rescue => e
				# Something else happened, completely unrelated to Stripe
			end
		end

		# Save stripe customer id to the db for persistence.
		if @customer
			self.customer_id = @customer.id
		end

		@customer
	end

	def customer_cached
		return customer if !self.customer_id
		Rails.cache.fetch("user/#{ self.id }/#{ self.updated_at }/#{ self.customer_id }/customer", expires_in: 1.minutes) do
			self.customer
		end
	end

	# =========================================
	# Cards
	# =========================================

	def add_card(stripe_token, primary: true)
		if primary
			replacement_card = customer.sources.first
		else
			replacement_card = customer.sources.retrieve(customer.sources.map(&:id).last) if customer.sources.count > 1
		end

		new_card = customer.sources.create(source:stripe_token)

		# Only update the default card if the new one is valid.
		if !new_card.blank? && !new_card.id.blank?
			customer.default_source = new_card.id if primary
			self.card_last_4 = new_card.last4
			self.card_type = new_card.brand
			# DISABLED ALL CARD DELETIONS
			# replacement_card.delete if replacement_card
			customer.save
		end
	end

	# =========================================
	# SUBSCRIPTIONS
	# =========================================

	# Subscription Object Helpers
	def subscription_id
		read_attribute(:subscription_id)
	end

	def subscription_id=(value)
		update_columns(subscription_id: value) if self.id
		write_attribute(:subscription_id, value)
	end

	def subscription
		return nil if !self.customer || !self.plan || !self.plan.stripe_id

		begin
			@subscription ||= self.customer.subscriptions.retrieve(self.subscription_id) if self.subscription_id
		rescue Stripe::StripeError => e
			# Display a very generic error to the user, and maybe send
			# yourself an email
		rescue => e
			# Something else happened, completely unrelated to Stripe
		end

		begin
			# @subscription ||= self.customer.subscriptions.first
		rescue Stripe::StripeError => e
			# Display a very generic error to the user, and maybe send
			# yourself an email
		rescue => e
			# Something else happened, completely unrelated to Stripe
		end

		begin
			@subscription ||= self.customer.subscriptions.create(:plan => self.plan.stripe_id)
		rescue Stripe::StripeError => e
			# Display a very generic error to the user, and maybe send
			# yourself an email
		rescue => e
			# Something else happened, completely unrelated to Stripe
		end

		self.subscription_id = @subscription.id if @subscription && @subscription.id

		@subscription
	end

	# Cancels current subscription.
	def cancel_subscription
		# self.subscription.delete(at_period_end: true) if self.subscription
		# self.subscription.prorate = false
		# self.plan = site.plans.where('amount <= 0').where(active: true).first
		# write_attribute(:active, false)
	end

	# Starts the current subscription on the current plan.
	def start_subscription
		if self.plan_id != self.plan_id_was && self.customer && self.subscription
			self.subscription.plan = self.plan.stripe_id
			self.subscription.save
			# write_attribute(:active, true)
		end
	end

	def needs_plan_upgrade?
		listings.where(billing_active:false).count > 0
	end

	# =========================================
	# HELPERS
	# =========================================

	def sync_with_stripe_later
		# Sync up all data with stripe.
		changed = false

		changed = true if !self.email.blank? && self.email != self.email_was
		changed = true if (self.contact_phone != self.contact_phone_was)
		changed = true if (self.plan_id != self.plan_id_was)
		changed = true if (self.first_name != self.first_name_was)
		changed = true if (self.last_name != self.last_name_was)

		ModelTaskJob.perform_later(self, "sync_with_stripe") if changed
	end

	def sync_with_stripe
		# Sync up all data with stripe.
		if self.customer_id && self.customer
			self.customer.email = self.email
			self.customer.description = self.customer_description
			self.customer.metadata[:contact_phone] = self.contact_phone if !self.contact_phone.blank?
			self.customer.metadata[:plan] = self.plan.name
			self.customer.metadata[:first_name] = self.first_name
			self.customer.metadata[:last_name] = self.last_name

			update_columns(card_last_4: self.customer.sources.first.last4, card_type: self.customer.sources.first.brand) if self.customer.sources.first

			self.customer.save
		end
	end

	def to_json(arg)

	end

	# =========================================
	# CLASS HELPERS
	# =========================================

	def self.enforce_billing_for_all_accounts
		# User.all.each do |user|
			# user.delay.enforce_billing_and_save
		# end
	end
end
