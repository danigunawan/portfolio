class AddClassReferenceToListingMetaCategory < ActiveRecord::Migration
  def change
    add_reference :listing_meta_categories, :class_reference, index: true
  end
end
