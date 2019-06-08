class AddContactEmailToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :contact_email, :string
  end
end
