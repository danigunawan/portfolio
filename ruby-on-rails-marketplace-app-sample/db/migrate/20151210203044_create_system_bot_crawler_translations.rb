class CreateSystemBotCrawlerTranslations < ActiveRecord::Migration
  def change
    create_table :system_bot_crawler_translations do |t|
      t.belongs_to :crawler, index: true
      t.belongs_to :category, index: true
      t.string :type
      t.string :output
      t.string :input

      t.timestamps
    end
  end
end
