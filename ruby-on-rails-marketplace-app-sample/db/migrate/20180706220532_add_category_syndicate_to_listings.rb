class AddCategorySyndicateToListings < ActiveRecord::Migration
  def change
    add_reference :listings, :category_syndicate, index: true, foreign_key: true
  end
end
