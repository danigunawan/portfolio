class RemoveHashFromListingDrafts < ActiveRecord::Migration
  def change
		remove_column :listing_drafts, :hash
  end
end
