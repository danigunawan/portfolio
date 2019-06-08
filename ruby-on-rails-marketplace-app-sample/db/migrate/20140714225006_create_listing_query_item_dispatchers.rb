class CreateListingQueryItemDispatchers < ActiveRecord::Migration
  def change
    create_table :listing_query_item_dispatchers do |t|
      t.belongs_to :query
		  t.belongs_to :listing_category_animal_alpaca_queries
		  t.belongs_to :listing_category_animal_buffalo_queries
		  t.belongs_to :listing_category_animal_camel_queries
		  t.belongs_to :listing_category_animal_cattle_queries
		  t.belongs_to :listing_category_animal_donkey_queries
		  t.belongs_to :listing_category_animal_goat_queries
		  t.belongs_to :listing_category_animal_horse_queries
		  t.belongs_to :listing_category_animal_llama_queries
		  t.belongs_to :listing_category_animal_poultry_queries
		  t.belongs_to :listing_category_animal_reindeer_queries
		  t.belongs_to :listing_category_animal_sheep_queries
		  t.belongs_to :listing_category_animal_swine_queries
		  t.belongs_to :listing_category_animal_yak_queries      
		  t.timestamps
    end
  end
end
