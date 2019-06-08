class CreateSystemAppearanceThemes < ActiveRecord::Migration
  def change
    create_table :system_appearance_themes do |t|
    	t.string :name
    	t.string :long_name
    	t.string :path
      t.timestamps
    end
  end
end
