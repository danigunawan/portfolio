class AddDeletedToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :deleted, :boolean
  end
end
