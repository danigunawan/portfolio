class AddAddressToListingListings < ActiveRecord::Migration
  def change
    add_column :listing_listings, :address, :string
  end
end
