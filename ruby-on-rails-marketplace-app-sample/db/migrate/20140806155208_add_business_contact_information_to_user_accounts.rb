class AddBusinessContactInformationToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :show_business_contact_information, :boolean
    add_column :user_accounts, :business_contact_name, :string
    add_column :user_accounts, :business_contact_email, :string
    add_column :user_accounts, :business_contact_phone, :string
  end
end
