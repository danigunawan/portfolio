class Business < ActiveRecord::Base
  # include ActionView::Helpers
	# include Impressionist::IsImpressionable

	# acts_as_paranoid
	# is_impressionable :counter_cache => true, :column_name => :views, :unique => [:session_hash]

	geocoded_by :address # can also be an IP address
	after_validation :geocode # auto-fetch coordinates
	has_paper_trail

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

	has_and_belongs_to_many :business_tags
	# Tags string helper for indexing and display.
	def tags
		business_tags.map(&:name).join(', ')
	end

	def title
		name
	end

	# ---------------------------------------------
	# Search Indexing via Solr
	# ---------------------------------------------

	searchable auto_index: true do
		text :description, :safe_address, :contact_name, :name, :tags
		integer :site_id
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

	# ---------------------------------------------
	# Content control helpers:
	# ---------------------------------------------

	extend FriendlyId
	friendly_id :slug_candidates, use: [:slugged, :history]

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

	def description_clean(session_account)
		return ""
		cleaned_description = self.title
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

	def location
		return safe_address
	end
end
