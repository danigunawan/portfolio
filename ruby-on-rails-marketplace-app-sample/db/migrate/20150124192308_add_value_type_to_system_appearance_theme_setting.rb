class AddValueTypeToSystemAppearanceThemeSetting < ActiveRecord::Migration
  def change
    add_reference :system_appearance_theme_settings, :value_type, index: true
  end
end
