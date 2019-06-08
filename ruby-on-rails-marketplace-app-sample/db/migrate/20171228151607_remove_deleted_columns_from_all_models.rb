class RemoveDeletedColumnsFromAllModels < ActiveRecord::Migration
  def change
		remove_column :favorites, :deleted
		remove_column :listings, :deleted
		remove_column :photos, :deleted
		remove_column :plans, :deleted
		remove_column :sites, :deleted
  end
end
