class AddDistanceToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :distance, :float
  end
end
