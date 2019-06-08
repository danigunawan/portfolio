class CategoryAttributeValue < ActiveRecord::Base
	before_validation :set_float_value

	belongs_to :category_attribute
	has_and_belongs_to_many :listings
	has_one :category,
		through: :category_attribute

	def to_s
		value
	end

	def set_float_value
		write_attribute(:float_value, value.to_s.to_f) if value && value.numeric?
	end

	def listings_count_cache
		Rails.cache.fetch("category_attribute_value/#{ self.id }/listings_count", expires_in: 3.hours) do
			self.listings.count
		end
	end
end
