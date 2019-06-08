class AddBillingActiveToListings < ActiveRecord::Migration
  def change
    add_column :listings, :billing_active, :boolean, default: false
  end
end
