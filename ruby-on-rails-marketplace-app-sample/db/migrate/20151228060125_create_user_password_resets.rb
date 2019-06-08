class CreateUserPasswordResets < ActiveRecord::Migration
  def change
    create_table :user_password_resets do |t|
      t.belongs_to :user, index: true
      t.boolean :complete, default: false
      t.boolean :sent_email, default: false
      t.timestamps
    end
  end
end
