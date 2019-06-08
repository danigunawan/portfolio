class AddRequiredToListingMetaCategoryAttributes < ActiveRecord::Migration
  def change
    add_column :listing_meta_category_attributes, :required, :boolean, default: true
  end
end
