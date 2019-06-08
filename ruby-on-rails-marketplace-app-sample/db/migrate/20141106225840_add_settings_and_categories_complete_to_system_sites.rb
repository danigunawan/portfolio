class AddSettingsAndCategoriesCompleteToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :settings_and_categories_complete, :boolean
  end
end
