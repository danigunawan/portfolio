class AddCategoryClassifierToListingMetaCategory < ActiveRecord::Migration
  def change
    add_reference :listing_meta_categories, :category_classifier, index: true
  end
end
