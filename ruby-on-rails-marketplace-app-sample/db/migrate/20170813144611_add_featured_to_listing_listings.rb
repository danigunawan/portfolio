class AddFeaturedToListingListings < ActiveRecord::Migration
  def change
    add_column :listing_listings, :featured, :boolean, default: false
  end
end
