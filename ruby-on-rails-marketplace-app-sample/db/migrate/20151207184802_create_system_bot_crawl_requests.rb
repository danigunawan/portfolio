class CreateSystemBotCrawlRequests < ActiveRecord::Migration
  def change
    create_table :system_bot_crawl_requests do |t|
      t.string :url
      t.datetime :expires
      t.integer :levels
      t.boolean :crawled
      t.text :content
      t.belongs_to :listing, index: true
      t.belongs_to :site, index: true
      t.datetime :crawled_at
      t.integer :failed_attempts
      t.boolean :deleted

      t.timestamps
    end
  end
end
