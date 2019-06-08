class AddPagesAndContentCompleteToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :pages_and_content_complete, :boolean
  end
end
