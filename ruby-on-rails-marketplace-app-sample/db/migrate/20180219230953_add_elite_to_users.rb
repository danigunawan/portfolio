class AddEliteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :elite, :boolean, default: false
  end
end
