class AddSafeAddressToListings < ActiveRecord::Migration
  def change
    add_column :listings, :safe_address, :string
  end
end
