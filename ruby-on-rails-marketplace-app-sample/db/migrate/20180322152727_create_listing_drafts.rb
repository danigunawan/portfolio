class CreateListingDrafts < ActiveRecord::Migration
  def change
    create_table :listing_drafts do |t|
      t.text :draft
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :site, index: true, foreign_key: true
      t.string :hasher
      t.belongs_to :listing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
