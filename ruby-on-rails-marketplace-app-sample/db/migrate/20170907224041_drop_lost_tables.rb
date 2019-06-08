class DropLostTables < ActiveRecord::Migration
  def change
		drop_table :user_locations
		drop_table :user_accounts
		drop_table :listing_listings_meta_payment_methods
		drop_table :ads_ad_zones_listing_meta_class_references
  end
end
