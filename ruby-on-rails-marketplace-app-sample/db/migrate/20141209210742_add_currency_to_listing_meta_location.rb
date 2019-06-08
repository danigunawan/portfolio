class AddCurrencyToListingMetaLocation < ActiveRecord::Migration
  def change
    add_reference :listing_meta_locations, :currency, index: true
  end
end
