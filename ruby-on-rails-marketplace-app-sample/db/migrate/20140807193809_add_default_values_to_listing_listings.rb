class AddDefaultValuesToListingListings < ActiveRecord::Migration
  def change
  	change_column :listing_listings, :complete, :boolean, :default => false
  	change_column :listing_listings, :deleted, :boolean, :default => false
  	change_column :listing_listings, :expired, :boolean, :default => false
  end
end
