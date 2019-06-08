class AddThemeAndSettingsCompleteToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :theme_and_settings_complete, :boolean
  end
end
