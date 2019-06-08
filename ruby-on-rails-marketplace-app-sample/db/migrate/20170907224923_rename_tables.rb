class RenameTables < ActiveRecord::Migration
  def change
		rename_table :listing_listings, :listings
		rename_table :listing_listings_meta_category_attribute_values, :category_attribute_values_listings
		rename_table :listing_meta_categories, :categories
		rename_table :listing_meta_categories_listings, :categories_listings
		rename_table :listing_meta_category_attribute_values, :category_attribute_values
		rename_table :listing_meta_category_attributes, :category_attributes
		rename_table :listing_meta_photo_file_assignments, :photo_assignments
		rename_table :listing_meta_photo_files, :photos
		rename_table :listing_queries, :queries
		rename_table :system_configuration_settings, :site_settings
		rename_table :system_meta_sitemap_entries, :links
		rename_table :system_sites, :sites

		drop_table :user_orders
		drop_table :user_password_resets
		drop_table :system_configuration_seos
		drop_table :listing_meta_locations_system_sites
  end
end
