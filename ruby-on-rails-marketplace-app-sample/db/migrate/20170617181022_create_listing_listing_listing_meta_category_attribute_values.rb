class CreateListingListingListingMetaCategoryAttributeValues < ActiveRecord::Migration
  def change
  	create_table :listing_listings_listing_meta_category_attribute_values, id: false do |t|
      t.belongs_to :listing
      t.belongs_to :category_attribute_value
    end
    add_index :listing_listings_listing_meta_category_attribute_values, [:listing_id, :category_attribute_value_id], name: :category_attribute_value_ids_listings_ids
    add_index :listing_listings_listing_meta_category_attribute_values, :category_attribute_value_id, name: :category_attribute_value_listings_cat_val_ids
  end
end
