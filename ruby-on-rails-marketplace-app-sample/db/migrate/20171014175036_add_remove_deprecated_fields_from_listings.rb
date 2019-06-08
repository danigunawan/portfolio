class AddRemoveDeprecatedFieldsFromListings < ActiveRecord::Migration
  def change
		remove_column :listings, :category_and_location_complete
		remove_column :listings, :details_and_description_complete
		remove_column :listings, :photos_and_videos_complete
		remove_column :listings, :pricing_and_terms_complete
		remove_column :listings, :contact_information_complete
		remove_column :listings, :business_contact_name
		remove_column :listings, :business_contact_email
		remove_column :listings, :business_contact_phone
		remove_column :listings, :show_business_contact_information
		remove_column :listings, :preferred_calling_time_id
		remove_column :listings, :preferred_calling_day_id
		remove_column :listings, :timezone_id
		remove_column :listings, :state_id
		remove_column :listings, :city_id
		remove_column :listings, :zip_code_id
  end
end
