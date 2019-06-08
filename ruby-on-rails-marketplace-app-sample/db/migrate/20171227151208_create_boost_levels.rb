class CreateBoostLevels < ActiveRecord::Migration
  def change
    create_table :boost_levels do |t|
      t.integer :level
			t.string :label
			t.float :price
			t.boolean :active, default: true

      t.belongs_to :site, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
