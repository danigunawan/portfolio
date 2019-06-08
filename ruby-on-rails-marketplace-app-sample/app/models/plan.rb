class Plan < ActiveRecord::Base

	serialize :metadata, JSON

	has_many :subscribers,
		class_name: 'User'

	before_save :set_default_data, :update_stripe_info
	before_update :update_stripe_info
	belongs_to :site

	def set_default_data
		self.metadata ||= {}
		self.metadata['listings'] ||= 0
		self.metadata['users'] ||= 0
	end

	def allowed? key
		self.metadata[key.to_s].to_s.to_logical == true || false
	end

	def listings
		self.metadata['listings'] ||= 0
		self.metadata['listings'].to_s.to_logical
	end

	# =========================================
	# HELPERS
	# =========================================

	def plan
		begin
			@plan ||= Stripe::Plan.retrieve(self.stripe_id, {api_key: site.env['STRIPE_SECRET_KEY']}) if self.stripe_id
		rescue Stripe::StripeError => e
			# Display a very generic error to the user, and maybe send
			# yourself an email
		rescue => e
			# Something else happened, completely unrelated to Stripe
		end
	end

	def update_stripe_info
		if self.plan
			self.plan.name = self.name if !self.name.blank?
			self.plan.trial_period_days = self.trial_period_days if !self.trial_period_days.blank?

			# Stripe holds priority over locally set metadata.
			self.plan.metadata.each do |key, value|
				self.metadata[key.to_s] = value
			end

			# Push out all locally set keys to stripe.
			self.metadata.each do |key, value|
				self.plan.metadata[key.to_s] = value
			end

			self.plan.save
		end
	end

	# =========================================
	# CLASS HELPERS
	# =========================================

	def self.sync_with_stripe
		# TODO: NAMESPACE to site.id
		Site.all.each do |site|
			if !site.env['STRIPE_SECRET_KEY'].blank?
				Stripe::Plan.all({},{api_key: site.env['STRIPE_SECRET_KEY']}).each do |stripe_plan|
					plan = site.plans.find_or_create_by(stripe_id: stripe_plan.id)
					plan.update({
						# stripe_id: "id", # "collaborator-v1-10-days"
						amount: stripe_plan.amount, # 0
						currency: stripe_plan.currency, # "usd"
						interval: stripe_plan.interval, # "month"
						interval_count: stripe_plan.interval_count, # 1
						name: stripe_plan.name, # "Collaborator"
						trial_period_days: stripe_plan.trial_period_days # 10
					})

					plan.save
				end
			end
		end
	end
end
