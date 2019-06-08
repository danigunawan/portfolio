class ReplacePhotoAssignmentWithListingPhotos < ActiveRecord::Migration
  def change
		drop_table :photo_assignments

		create_table :listings_photos, id: false do |t|
			t.integer :listing_id
			t.integer :photo_id
		end
  end
end
