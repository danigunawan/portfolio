class AddCardDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :card_last_4, :string
    add_column :users, :card_type, :string
    add_column :users, :on_trial, :boolean
  end
end
