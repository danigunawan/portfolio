class RemoveClassReferenceNameFromListingMetaCategory < ActiveRecord::Migration
  def change
    remove_column :listing_meta_categories, :class_reference_name, :string
  end
end
