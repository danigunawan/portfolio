class AddRemoveDeprecatedFieldsFromListings2 < ActiveRecord::Migration
  def change
		remove_column :listings, :edit_hash
		remove_column :listings, :delete_hash
		remove_column :listings, :continuation_url
  end
end
