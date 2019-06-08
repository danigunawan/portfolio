class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

			# Mapping to the current_site instance.
			t.belongs_to :site
			t.boolean :admin, default: false

			# Basic account information
			t.string :first_name
			t.string :last_name
			t.string :image

			t.string :uid
			t.string :provider
			t.string :oauth_token
			t.datetime :oauth_expires_at

			t.string :contact_phone
			t.string :contact_email

			t.boolean :show_business_contact_information

			t.string :business_contact_name
			t.string :business_contact_email
			t.string :business_contact_phone

			t.string :username
			t.string :encryption_method, default: "sha1", null: false

			## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
