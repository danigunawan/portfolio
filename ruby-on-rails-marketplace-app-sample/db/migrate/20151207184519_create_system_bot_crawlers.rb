class CreateSystemBotCrawlers < ActiveRecord::Migration
  def change
    create_table :system_bot_crawlers do |t|
      t.datetime :last_run
      t.string :scraper_model
      t.belongs_to :category_model, index: true
      t.string :host
      t.integer :minimum_seconds_between_crawls
      t.boolean :paused, default: false
      t.timestamps
    end
  end
end
