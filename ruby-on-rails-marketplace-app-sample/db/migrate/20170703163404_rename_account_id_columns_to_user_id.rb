class RenameAccountIdColumnsToUserId < ActiveRecord::Migration
  def change
		rename_column :listing_listing_contact_messages, :account_id, :user_id
		rename_column :listing_listings, :account_id, :user_id
		rename_column :listing_query_subscriptions, :account_id, :user_id
  end
end
