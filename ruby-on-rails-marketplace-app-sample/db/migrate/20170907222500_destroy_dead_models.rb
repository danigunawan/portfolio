class DestroyDeadModels < ActiveRecord::Migration
  def change
		drop_table :meta_flags
		drop_table :meta_order_statuses
		drop_table :meta_select_choices
		drop_table :meta_types
		drop_table :system_appearance_email_templates
		drop_table :system_appearance_menu_items
		drop_table :system_appearance_menus
		drop_table :system_appearance_theme_settings
		drop_table :system_appearance_themes
		drop_table :system_bot_crawl_requests
		drop_table :system_bot_crawler_translations
		drop_table :system_bot_crawlers
		drop_table :system_configuration_ad_zones
		drop_table :system_meta_files
		drop_table :system_meta_photo_files
		drop_table :system_external_subscribers
		drop_table :system_external_subscriptions
  end
end
