class CreateMetaTypes < ActiveRecord::Migration
  def change
    create_table :meta_types do |t|
      t.string :value_type
      t.boolean :eval, default: false
      t.timestamps
    end
  end
end
