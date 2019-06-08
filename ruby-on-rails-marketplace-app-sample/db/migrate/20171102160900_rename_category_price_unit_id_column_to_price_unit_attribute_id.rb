class RenameCategoryPriceUnitIdColumnToPriceUnitAttributeId < ActiveRecord::Migration
  def change
		rename_column :categories, :price_unit_id, :price_unit_attribute_id
  end
end
