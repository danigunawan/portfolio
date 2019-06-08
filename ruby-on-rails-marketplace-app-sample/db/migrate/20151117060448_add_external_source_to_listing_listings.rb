class AddExternalSourceToListingListings < ActiveRecord::Migration
  def change
    add_column :listing_listings, :external_source, :string
  end
end
