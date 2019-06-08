class AddLocationToListingDrafts < ActiveRecord::Migration
  def change
    add_column :listing_drafts, :location, :string
  end
end
