class RemoveListingsPhotos < ActiveRecord::Migration
  def change
		drop_table :listings_photos
  end
end
