class CreateSystemAppearanceMenuItems < ActiveRecord::Migration
  def change
    create_table :system_appearance_menu_items do |t|

      t.timestamps
    end
  end
end
