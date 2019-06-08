class AddPageIdToContentPages < ActiveRecord::Migration
  def change
    add_reference :content_pages, :page, index: true
  end
end
