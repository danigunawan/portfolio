class AddListingCategoryAnimalDuckQueriesToListingQueryItemDispatchers < ActiveRecord::Migration
  def change
    add_reference :listing_query_item_dispatchers, :listing_category_animal_duck_queries
    add_index :listing_query_item_dispatchers, :listing_category_animal_duck_queries_id, name: :listing_query_item_dispatchers_animal_duck_queries_id_index
  end
end
