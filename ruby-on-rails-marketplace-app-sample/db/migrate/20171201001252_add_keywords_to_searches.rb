class AddKeywordsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :keywords, :string
  end
end
