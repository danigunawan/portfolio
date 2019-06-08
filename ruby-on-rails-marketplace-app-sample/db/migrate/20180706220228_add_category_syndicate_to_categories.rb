class AddCategorySyndicateToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :category_syndicate, index: true, foreign_key: true
  end
end
