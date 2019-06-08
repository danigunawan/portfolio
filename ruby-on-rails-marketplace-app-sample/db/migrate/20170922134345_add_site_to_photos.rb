class AddSiteToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :site, index: true, foreign_key: true
  end
end
