class AddPublicKeyToSystemSite < ActiveRecord::Migration
  def change
    add_column :system_sites, :public_key, :string
  end
end
