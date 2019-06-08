class AddSaltToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :salt, :string
  end
end
