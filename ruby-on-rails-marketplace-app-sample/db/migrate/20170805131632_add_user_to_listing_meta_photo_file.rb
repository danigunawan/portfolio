class AddUserToListingMetaPhotoFile < ActiveRecord::Migration
  def change
    add_reference :listing_meta_photo_files, :user, index: true, foreign_key: true
  end
end
