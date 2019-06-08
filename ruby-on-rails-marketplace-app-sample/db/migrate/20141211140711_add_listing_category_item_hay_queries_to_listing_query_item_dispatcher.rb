class AddListingCategoryItemHayQueriesToListingQueryItemDispatcher < ActiveRecord::Migration
  def change
    add_reference :listing_query_item_dispatchers, :listing_category_item_hay_queries
  end
end
