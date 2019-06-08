class AddSiteToSystemAppearanceThemes < ActiveRecord::Migration
  def change
    add_reference :system_appearance_themes, :site, index: true
  end
end
