class RemoveDeletedFromSystemBotCrawlRequest < ActiveRecord::Migration
  def change
    remove_column :system_bot_crawl_requests, :deleted, :boolean
    remove_column :system_bot_crawl_requests, :crawled, :boolean
  end
end
