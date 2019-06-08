class AddPublishedToContentPages < ActiveRecord::Migration
  def change
    add_column :content_pages, :published, :boolean, default: false
  end
end
