class AddEditedAtToListingListing < ActiveRecord::Migration
  def change
    add_column :listing_listings, :edited_at, :datetime
  end
end
