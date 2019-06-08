class AddMigrationKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :migration_key, :string
  end
end
