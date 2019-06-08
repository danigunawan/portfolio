class AddStyleToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :stylesheet, :text
  end
end
