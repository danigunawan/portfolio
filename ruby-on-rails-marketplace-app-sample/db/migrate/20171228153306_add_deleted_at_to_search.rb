class AddDeletedAtToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :deleted_at, :datetime
    add_index :searches, :deleted_at
  end
end
