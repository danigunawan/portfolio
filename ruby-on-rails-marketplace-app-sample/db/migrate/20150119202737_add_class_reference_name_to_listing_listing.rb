class AddClassReferenceNameToListingListing < ActiveRecord::Migration
  def change
    add_column :listing_listings, :class_reference_name, :string
  end
end
