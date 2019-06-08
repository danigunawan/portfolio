class AddFeaturedPhotoUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :featured_photo_url, :string
  end
end
