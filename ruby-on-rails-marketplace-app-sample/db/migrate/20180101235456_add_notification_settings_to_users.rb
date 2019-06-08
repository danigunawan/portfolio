class AddNotificationSettingsToUsers < ActiveRecord::Migration
  def change
		add_column :users, :activity_notifications, :boolean, default: true
		add_column :users, :saved_search_notifications, :boolean, default: true
		add_column :users, :favorite_listing_notifications, :boolean, default: true
  end
end
