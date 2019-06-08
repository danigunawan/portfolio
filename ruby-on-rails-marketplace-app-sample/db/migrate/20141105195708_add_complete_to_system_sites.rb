class AddCompleteToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :complete, :boolean, default: false
  end
end
