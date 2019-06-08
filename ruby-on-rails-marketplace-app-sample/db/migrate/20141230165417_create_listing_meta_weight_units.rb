class CreateListingMetaWeightUnits < ActiveRecord::Migration
  def change
    create_table :listing_meta_weight_units do |t|
      t.string :name
      t.string :short_name
      t.boolean :published
      t.timestamps
    end
  end
end
