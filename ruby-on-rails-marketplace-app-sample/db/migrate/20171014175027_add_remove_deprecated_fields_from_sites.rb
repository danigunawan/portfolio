class AddRemoveDeprecatedFieldsFromSites < ActiveRecord::Migration
  def change
		remove_column :sites, :theme_and_settings_complete
		remove_column :sites, :pages_and_content_complete
		remove_column :sites, :categories_and_settings_complete
		remove_column :sites, :hostname_and_api_keys_complete
		remove_column :sites, :force_ssl
		remove_column :sites, :allow_shopping_cart
		remove_column :sites, :claim_hash
		remove_column :sites, :activate_hash
		remove_column :sites, :edit_hash
		remove_column :sites, :delete_hash
  end
end
