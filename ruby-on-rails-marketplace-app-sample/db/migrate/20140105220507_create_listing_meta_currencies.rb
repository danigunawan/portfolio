class CreateListingMetaCurrencies < ActiveRecord::Migration
  def change
    create_table :listing_meta_currencies do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  end
end
