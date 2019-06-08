class ListingMessage < ActiveRecord::Base
	geocoded_by :from_ip_address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	belongs_to :listing
	belongs_to :user

	def block?
		return true if self.name.downcase.include? "lindate ross"
		return true if body.length > 150
		return true if !self.user
		return true if self.user.is_suspended
		return true if self.user.listing_messages.where('created_at > ?',1.hour.ago).count > 5
		return true if !self.user.confirmed?

		if self.user.listing_messages.where('created_at > ?',10.minutes.ago).count >= 5
			self.user.update(is_suspended:true)
			return true
		end

		false
	end

	def name
		read_attribute(:name) || [first_name, last_name].join(' ')
	end
end
