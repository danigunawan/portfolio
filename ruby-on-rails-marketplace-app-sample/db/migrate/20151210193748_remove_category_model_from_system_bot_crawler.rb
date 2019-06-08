class RemoveCategoryModelFromSystemBotCrawler < ActiveRecord::Migration
  def change
  	remove_column :system_bot_crawlers, :category_model_id, :integer
  end
end
