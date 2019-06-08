class CreateListingListingItemDispatchers < ActiveRecord::Migration
  def change
    create_table :listing_listing_item_dispatchers do |t|
      t.belongs_to :listing
      t.timestamps
    end
  end
end
