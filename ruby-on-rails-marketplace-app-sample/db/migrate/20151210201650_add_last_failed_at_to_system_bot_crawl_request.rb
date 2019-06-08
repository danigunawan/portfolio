class AddLastFailedAtToSystemBotCrawlRequest < ActiveRecord::Migration
  def change
    add_column :system_bot_crawl_requests, :last_failed_at, :datetime
  end
end
