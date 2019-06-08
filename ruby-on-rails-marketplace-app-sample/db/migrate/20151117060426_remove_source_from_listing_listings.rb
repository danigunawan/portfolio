class RemoveSourceFromListingListings < ActiveRecord::Migration
  def change
  	remove_column :listing_listings, :source, :string
  end
end
