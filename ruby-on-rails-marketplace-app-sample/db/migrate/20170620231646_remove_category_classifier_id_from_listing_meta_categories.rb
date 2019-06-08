class RemoveCategoryClassifierIdFromListingMetaCategories < ActiveRecord::Migration
  def change
		remove_column :listing_meta_categories, :category_classifier_id
  end
end
