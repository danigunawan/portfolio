class AddSiteToSystemAppearanceThemeSettings < ActiveRecord::Migration
  def change
    add_reference :system_appearance_theme_settings, :site, index: true
  end
end
