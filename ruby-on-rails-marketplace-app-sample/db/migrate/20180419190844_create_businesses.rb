class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.belongs_to :site
      t.belongs_to :user

      t.string :name
      t.string :address
      t.string :safe_address
      t.float :latitude
      t.float :longitude

      t.string   :contact_name
      t.string   :contact_email
      t.string   :contact_phone

      t.datetime :edited_at
      t.string   :youtube_url
      t.string   :facebook_url
      t.string   :website_url

      t.string   :slug

      t.text     :description
      t.integer  :views,                    default: 0

      t.timestamps null: false
    end
  end
end
