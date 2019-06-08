class AddContactPhoneToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :contact_phone, :string
  end
end
