class DropOldModelTables < ActiveRecord::Migration
  def change
		drop_table :ads_ad_zones
		drop_table :ads_publishers
		drop_table :content_widget_ad_units
		drop_table :content_widget_recommended_listings
		drop_table :content_widget_sliders
		drop_table :content_widget_text_areas
		drop_table :content_page_widgets
		drop_table :content_pages
		drop_table :content_posts
		drop_table :listing_meta_locations
		drop_table :listing_meta_currencies
		drop_table :listing_meta_payment_methods
		drop_table :listing_meta_preferred_calling_days
		drop_table :listing_meta_preferred_calling_times
		drop_table :listing_meta_time_zones
		drop_table :listing_meta_weight_units
		drop_table :listing_listing_contact_messages
		drop_table :listing_query_subscriptions
  end
end
