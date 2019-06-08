class AddDescriptionToListingListing < ActiveRecord::Migration
  def change
    add_column :listing_listings, :description, :text
  end
end
