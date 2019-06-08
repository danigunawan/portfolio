class AddCategoriesAndSettingsCompleteToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :categories_and_settings_complete, :boolean, default: false
  end
end
