class AddDeletedToSystemBotCrawlRequest < ActiveRecord::Migration
  def change
    add_column :system_bot_crawl_requests, :deleted, :boolean, default:false
    add_column :system_bot_crawl_requests, :crawled, :boolean, default:false
  end
end
