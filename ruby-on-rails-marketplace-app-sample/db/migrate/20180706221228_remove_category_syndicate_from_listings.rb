class RemoveCategorySyndicateFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :category_syndicate_id
  end
end
