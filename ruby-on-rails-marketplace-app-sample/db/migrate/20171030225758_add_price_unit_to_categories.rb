class AddPriceUnitToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :price_unit, index: true
  end
end
