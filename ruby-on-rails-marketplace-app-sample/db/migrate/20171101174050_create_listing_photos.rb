class CreateListingPhotos < ActiveRecord::Migration
  def change
    create_table :listing_photos do |t|
      t.belongs_to :listing, index: true, foreign_key: true
      t.belongs_to :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
