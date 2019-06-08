class AddSlugToContentPages < ActiveRecord::Migration
  def change
    add_column :content_pages, :slug, :string
  end
end
