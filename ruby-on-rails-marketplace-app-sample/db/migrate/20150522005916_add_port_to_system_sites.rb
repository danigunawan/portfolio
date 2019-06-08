class AddPortToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :port, :integer
  end
end
