class CreatePhotoAssignments < ActiveRecord::Migration
  def change
    create_table :photo_assignments do |t|
      t.belongs_to :assignable, index: true
      t.string :assignable_type
      t.belongs_to :photo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
