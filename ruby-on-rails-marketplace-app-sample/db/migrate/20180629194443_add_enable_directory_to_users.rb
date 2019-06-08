class AddEnableDirectoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :enable_directory, :boolean, default: false
  end
end
