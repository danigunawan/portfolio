class CreateListingMetaCategories < ActiveRecord::Migration
  def change
    create_table :listing_meta_categories do |t|

      # Mapping to the current_site instance.
      t.belongs_to :site
      
      t.string :name
      t.boolean :published
      t.string :class_reference_name
      t.belongs_to :parent_category
      t.timestamps
    end

    create_table :listing_meta_categories_listings, id: false do |t|
      t.belongs_to :category
      t.belongs_to :listing
    end

    add_index :listing_meta_categories_listings, :category_id
  end
end
