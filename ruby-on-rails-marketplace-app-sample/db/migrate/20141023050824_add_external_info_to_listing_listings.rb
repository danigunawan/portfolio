class AddExternalInfoToListingListings < ActiveRecord::Migration
  def change
    add_column :listing_listings, :external, :boolean, default: false
    add_column :listing_listings, :source, :string
    add_column :listing_listings, :host, :string
  end
end
