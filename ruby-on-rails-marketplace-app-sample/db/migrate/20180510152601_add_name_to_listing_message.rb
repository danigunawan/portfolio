class AddNameToListingMessage < ActiveRecord::Migration
  def change
    add_column :listing_messages, :name, :string
  end
end
