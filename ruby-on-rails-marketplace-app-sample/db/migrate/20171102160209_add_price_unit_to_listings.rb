class AddPriceUnitToListings < ActiveRecord::Migration
  def change
    add_reference :listings, :price_unit, index: true
  end
end
