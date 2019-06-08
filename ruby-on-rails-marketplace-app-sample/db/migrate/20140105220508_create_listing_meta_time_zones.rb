class CreateListingMetaTimeZones < ActiveRecord::Migration
  def change
    create_table :listing_meta_time_zones do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  end
end
