class AddWeightUnitToListingMetaLocation < ActiveRecord::Migration
  def change
    add_reference :listing_meta_locations, :weight_unit, index: true
  end
end
