class RemoveDefaultSeoSettingFromSites < ActiveRecord::Migration
  def change
		remove_column :sites, :default_seo_setting_id
  end
end
