class AddDeletedAtToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :deleted_at, :datetime
    add_index :favorites, :deleted_at
  end
end
