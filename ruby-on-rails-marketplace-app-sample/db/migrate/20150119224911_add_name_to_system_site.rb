class AddNameToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :name, :string
  end
end
