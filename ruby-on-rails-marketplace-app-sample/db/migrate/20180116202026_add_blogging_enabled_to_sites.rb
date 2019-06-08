class AddBloggingEnabledToSites < ActiveRecord::Migration
  def change
    add_column :sites, :blogging_enabled, :boolean, default: false
  end
end
