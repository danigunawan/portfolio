class Listing < ActiveRecord::Base
	include ActionView::Helpers
	include Impressionist::IsImpressionable

	acts_as_paranoid
	is_impressionable :counter_cache => true, :column_name => :views, :unique => [:session_hash]
	has_paper_trail

	geocoded_by :address # can also be an IP address
	after_validation :geocode # auto-fetch coordinates

	def safe_address
		if (read_attribute(:safe_address).blank? && !self.address.blank?) or (!self.address.blank? && self.address != self.address_was)
			result = Geocoder.search(self.address).first
			update_columns(safe_address: [result.city, result.state].join(', ')) if result
			write_attribute(:safe_address, [result.city, result.state].join(', ')) if result
		end

		read_attribute(:safe_address)
	end

	belongs_to :site

	# All listings belong to an account (akin to a user model)
	belongs_to :user

	def contact_name
		return self.clean_name(read_attribute(:contact_name)) if !read_attribute(:contact_name).blank?
		return self.clean_name(user.contact_name) if user && !user.contact_name.blank?
		return self.clean_name(user.full_name) if user
		""
	end

	def clean_name(string)
		cleaned_string = string.to_s
		cleaned_string = cleaned_string.titleize if cleaned_string.scan(/[A-Z]/).length >= 0.4*cleaned_string.length
		cleaned_string.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip }
	end

	# Users can favorite, will destroy upwards on removal. i.e. soft remove from favorites of others.
	has_many :favorites,
		:dependent => :destroy

	# Listing featured configurations.
	belongs_to :boost_level
	belongs_to :boost_interval

	has_one :listing_draft

	def is_featured?
		return boost_level && boost_interval && boost_level.level > 0 && boost_interval.term > 0
	end

	def expired?
		(expired_at && expired_at < Time.now) or (deleted_at && deleted_at < Time.now)
	end

	# ---------------------------------------------
	# Search Indexing via Solr
	# ---------------------------------------------

	searchable auto_index: true do
		text :description, :title_dynamic, :safe_address, :title, :contact_name, :category_name
		integer :site_id
		integer :category_id
		integer :category_syndicate_id
		time :edited_at

		double :latitude
		double :longitude

		latlon(:latlon) {
			Sunspot::Util::Coordinates.new(latitude, longitude)
		}
	end

	def latlon
		latitude + ", " +  longitude
	end

	def self.search_query(query, site, category=nil, page=1, per_page=10)
		self.search do
			fulltext query do
				# boost(2.0) { with(:featured, true) }
			end

			with :site_id, site.id
			with :category_id, category.id if category
			order_by :edited_at, :desc
			paginate :page => page, :per_page => per_page
		end
	end

	# ---------------------------------------------
	# Content control helpers:
	# ---------------------------------------------

	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged, :history]

	def external(current_site=nil)
		if current_site and !current_site.nil? and !current_site.id.nil? and site
			return read_attribute(:external) || site.id != current_site.id
		end
		read_attribute(:external)
	end

	def url
		"http://#{ site.host }/listings/#{ slug }"
	end

	# Try building a slug based on the following fields in
	# increasing order of specificity.
	def slug_candidates
		if false && self.complete
			generate_link_path = self.title_long.downcase.gsub(",","")
			generate_link_path.strip!
			return [generate_link_path.gsub(" ","-"), generate_link_path.gsub(" ","-") + '-' + self.id.to_s ]
		else
			# Set of characters
			o = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten

			# Random string 80 in length is hash base.
			hash_string = (0...30).map { o[rand(o.length)] }.join

			# Create an array of partial random strings that increase in length from 5 up to 30.
			_slug_candidates = Array.new(hash_string.length)

			hash_string.length.times do |i|
				_slug_candidates[i] = hash_string[0,i+10]
			end

			return _slug_candidates
		end
	end

	# All listings belong to a category reference.
	# The category reference is a means of instantiating an
	# item model for the listing.
	#
	# FYI: The structure of the listing is such that all sale
	# 		 descriptions are attached to an item model.
	#
	belongs_to :category,
		class_name: "Category"
	delegate :name, to: :category, prefix: true

	def category_syndicate_id
		category.category_syndicate.id
	end

	has_and_belongs_to_many :category_attribute_values,
		class_name: "CategoryAttributeValue"

	delegate :category_attributes, to: :category

	# Request the correct price unit attribute from category. If it exists.
	delegate :price_unit_attribute, to: :category

	belongs_to :price_unit,
		class_name: "CategoryAttributeValue"

	# Request the correct price unit attribute from category. If it exists.
	delegate :quantity_unit_attribute, to: :category

	# Price unit is stored in category attributes.
	def quantity_unit
		category_attribute_values.where(category_attribute_id:quantity_unit_attribute.id).first if quantity_unit_attribute && quantity_unit_attribute.id
	end

	# =============================================
	# Helper Functions
	# =============================================

	# REQUIRES HASH INPUT: { ... CATEGORY_ATTRIBUTE_ID: CATEGORY_ATTRIBUTE_VALUE([VALUE|ID]) ... }
	# params[:listing][:category_attributes]
	def category_attribute_values_from_params(params)
		self.category_attribute_values = []
		if category && category_attributes && params && params.keys
			category_attributes.each do |category_attribute|
				if category_attribute.restricted
					if category_attribute.boolean
						category_attribute_value = category_attribute.category_attribute_values.find_or_create_by(value: params[category_attribute.id.to_s].to_s.gsub('number:','') == '1' ? '1' : '0')
					else
						category_attribute_value = category_attribute.category_attribute_values.where(id: params[category_attribute.id.to_s].to_s.gsub('number:','')).first
					end
				else
					category_attribute_value = category_attribute.category_attribute_values.find_or_create_by(value: params[category_attribute.id.to_s].to_s.gsub('number:',''))
				end

				category_attribute_values.push(category_attribute_value) if category_attribute_value
			end
		end
	end

	# ---------------------------------------------
	# Reference to media files models.
	# ---------------------------------------------

	has_many :listing_photos
	has_many :listing_messages

	# Associations to the listing through order:
	has_many :photos,
		-> { order('listing_photos.created_at') },
		through: :listing_photos

	accepts_nested_attributes_for :photos, :allow_destroy => true

	def placeholder_photo_path
		placeholder_number = self.id
		placeholder_number ||= 1
		placeholder_number = placeholder_number % 23

		# "listing-placeholders/#{ category.name.parameterize }-#{ placeholder_number }.jpg"
		"listing-placeholders/hay-#{ placeholder_number }.jpg"
	end

	def location
		return address
	end

	# ---------------------------------------------
	# Meta helpers:
	# ---------------------------------------------

	def title_short
		@title_short = headline
		@title_short ||= (self.category ? self.category.name : "Item")
	end

	def title
		@title = headline
		@title ||= self.title_short + " For Sale"
	end

	def title_long
		@title_long = self.title
		@title_long = @title_long.gsub("	"," ")
	end

	def title_dynamic
		@title_dynamic = title
		@title_dynamic ||= (category_attribute_values.map(&:value) + [ (category ? category.name : '') ]).join(' ').titleize
	end

	def link
		"/" + self.slug if self.slug
	end

	def video_url
		return nil if not self.youtube_url or self.youtube_url.length < 5
		require 'uri'
		return URI.parse(self.youtube_url).host.index("youtube") ? self.youtube_url : nil
	end

	def description_clean(session_account)
		cleaned_description = self.description
		# Lowercase CAPSLOCK ABUSE
		cleaned_description = cleaned_description.humanize if self.description.to_s.scan(/[A-Z]/).length >= 0.4*self.description.to_s.length
		# Capitalize each first letter of sentences.
		cleaned_description = cleaned_description.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip }

		return cleaned_description

		# Cleans phone numbers, emails and names from descriptions.
		# cleaned_description.gsub(/(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}/, '(XXX) XXX-XXXX').
		# 	gsub(/(http|https)?(\:\/\/)?([a-zA-Z0-9]+)?\.?([a-zA-Z0-9]+)\.([a-zA-Z0-9]+)\.?([a-zA-Z0-9]+)?([a-zA-Z0-9\.\/]+)?/, ' ... ').
		# 	gsub(/([a-zA-Z0-9._%+-]+)?@([a-zA-Z0-9.-]+)?\.?([a-zA-Z0-9]{2,4})?/, ' ... ')
	end

	def price
		if Monetize.parse(read_attribute(:price)).fractional == 0.0
			"Call"
		else
			humanized_money_with_symbol(Monetize.parse(read_attribute(:price)).to_s)
		end
	end

	def price_plain
		read_attribute(:price).to_s
	end

	def price_unit_formatted
		if price == "Call"
			""
		else
			(price_unit).value.downcase.gsub('per','/').titleize if price_unit
		end
	end

	def edited_at
		read_attribute(:edited_at) || updated_at
	end

	# ---------------------------------------------
	# Population helpers:
	# ---------------------------------------------

	def add_listing_to_sitemap
		site.links.find_or_create_by(path:"/detailed#{ path }").update(lastmod:updated_at)
	end

	def self.update_random_listing
		old_listings = Listing.where('edited_at > ?',7.months.ago).limit(100)
		old_listings.sample.update(edited_at:Time.now + rand(0..100).minutes) if old_listings
	end
end
