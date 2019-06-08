class AddDeletedAtToSavedSearch < ActiveRecord::Migration
  def change
    add_column :saved_searches, :deleted_at, :datetime
    add_index :saved_searches, :deleted_at
  end
end
