class Category < ActiveRecord::Base
	belongs_to :site

	before_validation do
		self.site_id = self.category.site_id if self.category
	end

	has_many :searches

	after_create :category_syndicate
	after_save :category_syndicate

	has_paper_trail

	has_many :categories,
		:foreign_key => "parent_category_id"

	belongs_to :category,
		:foreign_key => "parent_category_id"

	# Category Syndication to "clone" the data set across other categories.
	belongs_to :category_syndicate

	def category_syndicate
		if read_attribute(:category_syndicate_id).blank?
			result = CategorySyndicate.find_or_create_by(name:self.name)
			update_columns(category_syndicate_id: result.id) if result
			write_attribute(:category_syndicate_id, result.id) if result
		end

		super
	end
	# ----------------------------------------------------

	has_many :category_attributes

	def category_attributes
		super.where.not(id:price_unit_attribute_id).where(published: true)
	end

	belongs_to :price_unit_attribute,
		class_name: "CategoryAttribute"

	# Direct assignments of Listing <=> Category
	has_many :listings

	def query
		Query.load_from_params({ category_id: self.id }, self.site)
	end

	def assignable?
		return !categories.blank?
	end

	def locked?
		listings.count > 0
	end

	def title
		name.pluralize
	end

	rails_admin do
		edit do
			exclude_fields :listings
		end
	end
end
