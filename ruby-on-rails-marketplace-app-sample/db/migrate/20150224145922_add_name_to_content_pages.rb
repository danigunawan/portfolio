class AddNameToContentPages < ActiveRecord::Migration
  def change
    add_column :content_pages, :name, :string
  end
end
