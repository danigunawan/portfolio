class CreateListingMessages < ActiveRecord::Migration
  def change
    create_table :listing_messages do |t|
      t.belongs_to :listing, index: true, foreign_key: true
      t.boolean :sent, default: false
      t.belongs_to :user, index: true, foreign_key: true
      t.string :from_ip_address
      t.string :from_email
      t.string :phone
      t.string :last_name
      t.string :first_name
      t.text :body

      t.timestamps null: false
    end
  end
end
