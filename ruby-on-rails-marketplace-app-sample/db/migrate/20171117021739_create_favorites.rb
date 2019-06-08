class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :listing, index: true, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps null: false
    end
  end
end
