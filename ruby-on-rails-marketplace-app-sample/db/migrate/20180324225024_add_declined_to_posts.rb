class AddDeclinedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :declined, :boolean, default: false
  end
end
