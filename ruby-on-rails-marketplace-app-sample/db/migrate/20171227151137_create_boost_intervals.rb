class CreateBoostIntervals < ActiveRecord::Migration
  def change
    create_table :boost_intervals do |t|
      t.integer :term
			t.string :label
			t.float :discount
			t.boolean :active, default: true

			t.belongs_to :site, index: true, foreign_key: true
			t.timestamps null: false
    end
  end
end
