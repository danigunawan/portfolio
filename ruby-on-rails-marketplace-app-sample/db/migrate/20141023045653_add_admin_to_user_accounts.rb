class AddAdminToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :admin, :boolean, :default => false
  end
end
