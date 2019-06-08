class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.belongs_to :user, index: true
      t.string :ip_address, index: true
      t.float :latitude 
      t.float :longitude
      t.timestamps
    end
  end
end
