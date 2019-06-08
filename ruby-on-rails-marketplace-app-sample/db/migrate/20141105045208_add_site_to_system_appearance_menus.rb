class AddSiteToSystemAppearanceMenus < ActiveRecord::Migration
  def change
    add_reference :system_appearance_menus, :site, index: true
  end
end
