class AddActivatedAtToListings < ActiveRecord::Migration
  def change
    add_column :listings, :activated_at, :datetime
  end
end
