class CreateAdsAdZones < ActiveRecord::Migration
  def change
    create_table :ads_ad_zones do |t|
      t.belongs_to :publisher, index: true
      t.integer :width
      t.integer :height
      t.string :public_id, index: true
      t.timestamps
    end

    create_table :ads_ad_zones_listing_meta_class_references, id: false do |t|
      t.belongs_to :ad_zone
      t.belongs_to :class_reference
    end

    add_index :ads_ad_zones_listing_meta_class_references, :ad_zone_id, :name => 'ad_zones_meta_class_references_ad_zone_id_index'
    add_index :ads_ad_zones_listing_meta_class_references, :class_reference_id, :name => 'ad_zones_meta_class_references_class_reference_id_index'
  end
end
