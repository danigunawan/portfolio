class CreateTemplateFiles < ActiveRecord::Migration
  def change
    create_table :template_files do |t|
      t.text :body
      t.string :path
      t.string :locale
      t.string :handler
      t.boolean :partial, default: false
      t.string :format

      t.timestamps null: false
    end
  end
end
