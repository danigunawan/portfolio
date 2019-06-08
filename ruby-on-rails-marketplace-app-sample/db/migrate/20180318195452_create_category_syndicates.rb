class CreateCategorySyndicates < ActiveRecord::Migration
  def change
    create_table :category_syndicates do |t|
      t.belongs_to :category_source, index: true
      t.belongs_to :category_destination, index: true

      t.timestamps null: false
    end
  end
end
