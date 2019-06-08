class AddImageToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :image, :string
  end
end
