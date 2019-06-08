class AddForceSslToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :force_ssl, :boolean, default: false
  end
end
