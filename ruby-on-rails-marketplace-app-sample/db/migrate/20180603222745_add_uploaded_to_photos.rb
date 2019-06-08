class AddUploadedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :uploaded, :boolean, default: false
  end
end
