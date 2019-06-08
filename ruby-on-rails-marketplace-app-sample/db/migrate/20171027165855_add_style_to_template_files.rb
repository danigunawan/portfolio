class AddStyleToTemplateFiles < ActiveRecord::Migration
  def change
    add_column :template_files, :style, :text
  end
end
