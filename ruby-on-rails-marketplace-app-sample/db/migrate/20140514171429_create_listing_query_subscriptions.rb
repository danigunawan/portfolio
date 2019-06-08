class CreateListingQuerySubscriptions < ActiveRecord::Migration
  def change
    create_table :listing_query_subscriptions do |t|
      t.belongs_to :query
      t.belongs_to :account
      t.datetime :datetime_last_notified
      t.timestamps
    end
  end
end
