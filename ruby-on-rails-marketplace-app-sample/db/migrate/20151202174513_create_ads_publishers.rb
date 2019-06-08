class CreateAdsPublishers < ActiveRecord::Migration
  def change
    create_table :ads_publishers do |t|
      t.string :host, index: true
      t.boolean :active, index: true
      t.boolean :deleted
      t.timestamps
    end
  end
end
