class CreateListingMetaPaymentMethods < ActiveRecord::Migration
  def change
    create_table :listing_meta_payment_methods do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end

    create_table :listing_listings_meta_payment_methods, id: false do |t|
      t.belongs_to :payment_method
      t.belongs_to :listing
    end
  end
end