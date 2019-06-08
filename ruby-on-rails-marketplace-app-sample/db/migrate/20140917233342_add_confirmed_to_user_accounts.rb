class AddConfirmedToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :confirmed, :boolean
  end
end
