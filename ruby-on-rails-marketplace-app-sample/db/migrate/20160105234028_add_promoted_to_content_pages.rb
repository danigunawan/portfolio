class AddPromotedToContentPages < ActiveRecord::Migration
  def change
    add_column :content_pages, :promoted, :boolean, default: false
  end
end
