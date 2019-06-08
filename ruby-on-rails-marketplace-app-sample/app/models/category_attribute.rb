class CategoryAttribute < ActiveRecord::Base

	belongs_to :category
	belongs_to :category_attribute

	has_many :category_attribute_values

	serialize :config

	def to_s
		name
	end
end
