class CreateListingMetaPhotoFileAssignments < ActiveRecord::Migration
  def change
    create_table :listing_meta_photo_file_assignments do |t|
      t.belongs_to :listing
      t.belongs_to :photo
      t.timestamps
    end
  end
end
