class AddHostnameAndApiKeysCompleteToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :hostname_and_api_keys_complete, :boolean, default: false
  end
end
