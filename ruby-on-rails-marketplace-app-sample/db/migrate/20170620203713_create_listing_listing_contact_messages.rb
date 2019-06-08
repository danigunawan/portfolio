class CreateListingListingContactMessages < ActiveRecord::Migration
  def change
    create_table :listing_listing_contact_messages do |t|
    	
    	t.belongs_to :account
    	t.belongs_to :listing

        t.string :from_email
        
        t.belongs_to :city
        t.belongs_to :state

        t.string :first_name
        t.string :last_name

        t.string :phone
        t.text :comments

        t.boolean :has_transportation, default: false

        t.string :body
    	t.string :subject
    	
    	t.boolean :sent, default: false
    	t.boolean :complete, default: false
    	
    	t.string :public_key

        t.timestamps
    end
  end
end
