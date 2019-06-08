class AddAuthAttributesToUserAccounts < ActiveRecord::Migration
  def change
  	add_column :user_accounts, :username, :string
  	add_column :user_accounts, :facebook_token, :string

  	## Database authenticatable
  	change_column :user_accounts, :email, :string, null: false, default: ""
  	add_column :user_accounts, :encrypted_password, :string, null: false, default: ""
  	add_column :user_accounts, :encryption_method, :string, null: false, default: "sha1"

  	## Recoverable
  	add_column :user_accounts, :reset_password_token, :string
  	add_column :user_accounts, :reset_password_sent_at, :datetime

  	## Rememberable
  	add_column :user_accounts, :remember_created_at, :datetime

  	## Trackable
  	add_column :user_accounts, :sign_in_count, :integer, default: 0
  	add_column :user_accounts, :current_sign_in_at, :datetime
  	add_column :user_accounts, :last_sign_in_at, :datetime
  	add_column :user_accounts, :current_sign_in_ip, :string
  	add_column :user_accounts, :last_sign_in_ip, :string

  	## Confirmable
  	add_column :user_accounts, :confirmation_token, :string
  	add_column :user_accounts, :confirmed_at, :string
  	add_column :user_accounts, :confirmation_sent_at, :datetime
  	add_column :user_accounts, :unconfirmed_email, :string # Only if using reconfirmable

  	## Lockable
  	add_column :user_accounts, :failed_attempts, :integer, default: 0 # Only if lock strategy is :failed_attempts
  	add_column :user_accounts, :unlock_token, :string # Only if unlock strategy is :email or :both
  	add_column :user_accounts, :locked_at, :datetime
  end
end
