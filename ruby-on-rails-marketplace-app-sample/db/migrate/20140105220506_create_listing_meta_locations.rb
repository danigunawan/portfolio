class CreateListingMetaLocations < ActiveRecord::Migration
  def change
    create_table :listing_meta_locations do |t|
      t.string :name
      t.string :article
      t.boolean :published
      t.string :type      
      t.belongs_to :parent_location
      t.timestamps
    end
  end
end
