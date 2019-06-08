class CreateListingQueries < ActiveRecord::Migration
  def change
    create_table :listing_queries do |t|

      # Mapping to the current_site instance.
      t.belongs_to :site

      # Hash string for quickly indexing models without multi attribute queries.
      t.string :hash_key
      t.string :quick_hash_key
      t.string :version
      
      t.integer :results_count
      t.datetime :datetime_results_count_last_updated

      # This is the category item mapping for selecting categories.
      t.belongs_to :category
      
      t.belongs_to :country
      t.belongs_to :state
      t.belongs_to :city
      t.belongs_to :zip_code

      t.boolean :has_photos
      t.boolean :has_videos

      t.float :price_min
      t.float :price_max

      t.belongs_to :currency
      t.boolean :transportation_available

      # Reference to the official published listing item.
      #
      # Note: There are references from each item back to the 
      # listing item to streamline the editing process.
      t.references :item_query, polymorphic: true

      #---------------------------------------------------------------

      t.string :slug

      t.timestamps
    end

    create_table :listing_queries_queries, id: false do |t|
      t.belongs_to :parent_query
      t.belongs_to :sub_query
    end

    add_index :listing_queries, :site_id
    add_index :listing_queries, :slug
    add_index :listing_queries, :hash_key, unique: true
    add_index :listing_queries, :quick_hash_key, unique: true
    add_index :listing_queries, :results_count
  end
end
