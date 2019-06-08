class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.belongs_to :site, index: true, foreign_key: true
      t.integer :results_count
      t.datetime :datetime_results_count_last_updated
      t.belongs_to :category, index: true, foreign_key: true
      t.float :price_min
      t.float :price_max
      t.string :slug, index:true
      t.string :location, index:true

      t.timestamps null: false
    end
  end
end
