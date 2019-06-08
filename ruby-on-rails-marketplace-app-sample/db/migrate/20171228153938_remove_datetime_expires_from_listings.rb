class RemoveDatetimeExpiresFromListings < ActiveRecord::Migration
  def change
		remove_column :listings, :datetime_expires
  end
end
