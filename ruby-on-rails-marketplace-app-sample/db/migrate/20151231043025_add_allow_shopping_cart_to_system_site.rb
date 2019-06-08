class AddAllowShoppingCartToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :allow_shopping_cart, :boolean, default: false
  end
end
