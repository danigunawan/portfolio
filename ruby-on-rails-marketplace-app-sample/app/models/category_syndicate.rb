# Category(ies) -> CategorySyndicate
# Used for grouping categories across sites.
class CategorySyndicate < ActiveRecord::Base
	has_many :categories
end
