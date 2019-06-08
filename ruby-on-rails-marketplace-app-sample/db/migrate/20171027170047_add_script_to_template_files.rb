class AddScriptToTemplateFiles < ActiveRecord::Migration
  def change
    add_column :template_files, :script, :text
  end
end
