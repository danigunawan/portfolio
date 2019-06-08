class AddActivateHashToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :activate_hash, :string
  end
end
