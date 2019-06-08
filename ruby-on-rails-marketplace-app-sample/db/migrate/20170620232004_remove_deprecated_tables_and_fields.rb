class RemoveDeprecatedTablesAndFields < ActiveRecord::Migration
  def change
		drop_table :listing_listing_item_dispatchers
		drop_table :listing_queries_queries

		remove_column :listing_queries, :item_query_id
		remove_column :listing_queries, :item_query_type
		remove_column :listing_queries, :zip_code_id
		remove_column :listing_queries, :version
		remove_column :listing_queries, :quick_hash_key
		remove_column :listing_queries, :hash_key
		remove_column :listing_meta_categories, :class_reference_id
		remove_column :listing_listings, :item_id
		remove_column :listing_listings, :item_type
		remove_column :listing_listings, :class_reference_name
  end
end
