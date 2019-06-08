class AddBillingActiveAgainToListings < ActiveRecord::Migration
  def change
    add_column :listings, :billing_active, :boolean, default: true
  end
end
