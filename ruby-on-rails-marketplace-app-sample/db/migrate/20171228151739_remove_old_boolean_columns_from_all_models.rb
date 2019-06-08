class RemoveOldBooleanColumnsFromAllModels < ActiveRecord::Migration
  def change
		remove_column :listings, :complete
		remove_column :listings, :expired
		remove_column :listings, :featured
		remove_column :listings, :billing_active
		remove_column :photos, :active
		remove_column :photos, :uploaded
		remove_column :sites, :claimed
		remove_column :sites, :complete
  end
end
