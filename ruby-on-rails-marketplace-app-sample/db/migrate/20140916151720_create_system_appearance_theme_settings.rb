class CreateSystemAppearanceThemeSettings < ActiveRecord::Migration
  def change
    create_table :system_appearance_theme_settings do |t|
    
    	t.string :type

      t.belongs_to :theme, null: false
    	
    	t.string :key
    	t.string :value

      t.timestamps
    end

    add_index :system_appearance_theme_settings, :theme_id
    add_index :system_appearance_theme_settings, :key
  end
end
