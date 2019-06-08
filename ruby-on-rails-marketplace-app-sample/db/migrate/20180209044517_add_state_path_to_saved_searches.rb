class AddStatePathToSavedSearches < ActiveRecord::Migration
  def change
    add_column :saved_searches, :state_path, :string
  end
end
