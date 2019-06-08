class CreateListingMetaCategoryIdentifiers < ActiveRecord::Migration
  def change
    create_table :listing_meta_category_identifiers do |t|
    	t.belongs_to :listing
    	t.belongs_to :category
    	t.integer :identifier, limit: 8
      t.timestamps
    end
  end
end
