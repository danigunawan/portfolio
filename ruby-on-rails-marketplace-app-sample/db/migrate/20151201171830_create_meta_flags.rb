class CreateMetaFlags < ActiveRecord::Migration
  def change
    create_table :meta_flags do |t|
      t.belongs_to :user, index: true
      t.belongs_to :site, index: true
      
      t.integer :flaggable_id, index: true
      t.string  :flaggable_type
      t.datetime :flagged_at

      t.timestamps
    end
  end
end
