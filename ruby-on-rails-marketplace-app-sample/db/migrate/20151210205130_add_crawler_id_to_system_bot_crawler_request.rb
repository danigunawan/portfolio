class AddCrawlerIdToSystemBotCrawlerRequest < ActiveRecord::Migration
  def change
    add_reference :system_bot_crawl_requests, :crawler, index: true
  end
end
