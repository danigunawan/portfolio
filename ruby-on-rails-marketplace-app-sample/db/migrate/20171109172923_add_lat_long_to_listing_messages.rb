class AddLatLongToListingMessages < ActiveRecord::Migration
  def change
    add_column :listing_messages, :latitude, :float
    add_column :listing_messages, :longitude, :float
  end
end
