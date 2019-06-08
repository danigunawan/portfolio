class RemoveDatetimeDeletedFromListings < ActiveRecord::Migration
  def change
		remove_column :listings, :datetime_deleted
  end
end
