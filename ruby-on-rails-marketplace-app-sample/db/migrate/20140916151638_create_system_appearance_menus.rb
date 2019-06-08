class CreateSystemAppearanceMenus < ActiveRecord::Migration
  def change
    create_table :system_appearance_menus do |t|

      t.timestamps
    end
  end
end
