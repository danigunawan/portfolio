class CreateSystemMetaSitemapEntries < ActiveRecord::Migration
  def change
    create_table :system_meta_sitemap_entries do |t|
      t.belongs_to :site, index: true
      t.string :path
      t.boolean :indexed, default: false
      t.datetime :lastmod
      t.timestamps
    end
  end
end
