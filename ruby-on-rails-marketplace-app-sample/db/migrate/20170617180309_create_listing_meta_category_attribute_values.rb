class CreateListingMetaCategoryAttributeValues < ActiveRecord::Migration
  def change
    create_table :listing_meta_category_attribute_values do |t|
			t.string :value
			t.float :float_value

			t.float :priority
			t.boolean :published, :boolean, default: true

			t.belongs_to :category_attribute

			t.timestamps null: false
    end
  end
end
