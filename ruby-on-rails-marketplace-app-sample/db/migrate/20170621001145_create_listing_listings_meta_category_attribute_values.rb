class CreateListingListingsMetaCategoryAttributeValues < ActiveRecord::Migration
  def change
		drop_table :listing_listings_listing_meta_category_attribute_values

		create_table :listing_listings_meta_category_attribute_values, id: false, force: :cascade do |t|
			t.integer "listing_id"
			t.integer "category_attribute_value_id"
    end

		add_index :listing_listings_meta_category_attribute_values, [:listing_id, :category_attribute_value_id], name: :category_attribute_value_ids_listings_ids
		add_index :listing_listings_meta_category_attribute_values, :category_attribute_value_id, name: :category_attribute_value_listings_cat_val_ids
  end
end
