class AddHostIndexToSystemSites < ActiveRecord::Migration
  def change
		add_index :system_sites, :host, :unique => true
  end
end
