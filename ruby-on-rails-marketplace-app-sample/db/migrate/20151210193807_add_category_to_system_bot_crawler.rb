class AddCategoryToSystemBotCrawler < ActiveRecord::Migration
  def change
    add_reference :system_bot_crawlers, :category, index: true
  end
end
