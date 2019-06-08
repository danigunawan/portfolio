class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|

      # Mapping to the current_site instance.
      t.belongs_to :site
      
      # Basic account information
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password

      # OAuth Log in information (Facebook)
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.datetime :oauth_expires_at

      # Auth meta meta
      t.datetime :last_login
      t.datetime :last_active

      # GEO Meta
      t.belongs_to :city
      t.belongs_to :state
      t.belongs_to :country

      t.timestamps
    end
  end
end
