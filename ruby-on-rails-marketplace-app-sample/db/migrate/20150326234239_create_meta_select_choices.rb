class CreateMetaSelectChoices < ActiveRecord::Migration
  def change
    create_table :meta_select_choices do |t|
    	t.string :choice_group
    	t.string :label
    	t.string :value
      t.timestamps
    end
  end
end
