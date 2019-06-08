class CreateListingListings < ActiveRecord::Migration
  def change
    create_table :listing_listings do |t|
      
      # Mapping to the current_site instance.
      t.belongs_to :site

      # Mapping to the users account model.
      t.belongs_to :account
      
      #---------------------------------------------------------------

      t.belongs_to :country
      t.belongs_to :state
      t.belongs_to :city
      t.belongs_to :zip_code

      t.string :youtube_url

      t.float :price
      t.belongs_to :currency
      t.boolean :transportation_available

      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.belongs_to :preferred_calling_time
      t.belongs_to :preferred_calling_day
      t.belongs_to :timezone

      t.boolean :show_business_contact_information
      t.string :business_contact_name
      t.string :business_contact_email
      t.string :business_contact_phone
      
      #---------------------------------------------------------------

      t.boolean :category_and_location_complete, :default => false
      t.boolean :details_and_description_complete, :default => false
      t.boolean :photos_and_videos_complete, :default => false
      t.boolean :pricing_and_terms_complete, :default => false
      t.boolean :contact_information_complete, :default => false

      #---------------------------------------------------------------

      # References to the Listing<=>Item Mapping System

      # This is the category item mapping for selecting categories.
      t.belongs_to :category

      # Reference to the official published listing item.
      #
      # Note: There are references from each item back to the 
      # listing item to streamline the editing process.
      t.references :item, polymorphic: true

      #---------------------------------------------------------------

      # Maintenance/Internal Use Variables
      t.datetime :datetime_expires
      t.datetime :datetime_deleted

      # Boolean Flags.  
      t.boolean :complete
      t.boolean :expired
      t.boolean :deleted

      t.string :edit_hash
      t.string :delete_hash

      # Completion link reference for referring to the next step in
      # the creation forms.
      t.string :continuation_url

      t.string :slug

      t.timestamps
    end

    add_index :listing_listings, :slug
  end
end
