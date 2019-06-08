class AddMigrationKeyToListings < ActiveRecord::Migration
  def change
    add_column :listings, :migration_key, :string
  end
end
