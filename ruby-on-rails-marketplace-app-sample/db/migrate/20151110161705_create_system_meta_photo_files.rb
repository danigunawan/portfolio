class CreateSystemMetaPhotoFiles < ActiveRecord::Migration
  def change
    create_table :system_meta_photo_files do |t|
    	t.belongs_to :site
      t.timestamps
    end
  end
end
