class AddSiteToTemplateFiles < ActiveRecord::Migration
  def change
    add_reference :template_files, :site, index: true, foreign_key: true
  end
end
