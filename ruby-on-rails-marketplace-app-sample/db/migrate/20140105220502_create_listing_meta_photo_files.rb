class CreateListingMetaPhotoFiles < ActiveRecord::Migration
  def change
    create_table :listing_meta_photo_files do |t|
      t.belongs_to :listing_reference
      t.timestamps
    end
  end
end
