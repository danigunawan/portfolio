class AddBuyableToListingListing < ActiveRecord::Migration
  def change
    add_column :listing_listings, :buyable, :boolean, default: false
  end
end
