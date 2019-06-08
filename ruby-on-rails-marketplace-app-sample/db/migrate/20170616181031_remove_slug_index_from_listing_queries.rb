class RemoveSlugIndexFromListingQueries < ActiveRecord::Migration
  def change
		remove_index :listing_queries, :hash_key
		remove_index :listing_queries, :quick_hash_key
	end
end
