class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :search, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
