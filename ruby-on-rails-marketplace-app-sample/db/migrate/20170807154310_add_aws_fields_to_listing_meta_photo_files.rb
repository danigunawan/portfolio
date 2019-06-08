class AddAwsFieldsToListingMetaPhotoFiles < ActiveRecord::Migration
  def change
    add_column :listing_meta_photo_files, :key, :string
    add_column :listing_meta_photo_files, :uploaded, :boolean, default: false
    add_column :listing_meta_photo_files, :active, :boolean, default: true
    add_column :listing_meta_photo_files, :title, :string
    add_column :listing_meta_photo_files, :description, :string
    add_column :listing_meta_photo_files, :processed, :boolean, default: false
    add_column :listing_meta_photo_files, :deleted, :boolean, default: false
  end
end
