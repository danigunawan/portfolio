class RemoveSettingsAndCategoriesCompleteFromSystemSite < ActiveRecord::Migration
  def change
    remove_column :system_sites, :settings_and_categories_complete, :boolean
  end
end
