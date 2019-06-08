class CreateListingMetaCategoryAttributes < ActiveRecord::Migration
  def change
    create_table :listing_meta_category_attributes do |t|
			t.string :name
			t.text :config

			t.belongs_to :category
			t.belongs_to :category_attribute

			t.boolean :published, :boolean, default: true
			t.boolean :restricted, :boolean, default: false
			t.float :priority

			t.timestamps null: false
    end
  end
end
