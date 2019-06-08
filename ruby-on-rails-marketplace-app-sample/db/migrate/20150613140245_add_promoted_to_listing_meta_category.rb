class AddPromotedToListingMetaCategory < ActiveRecord::Migration
  def change
    add_column :listing_meta_categories, :promoted, :boolean, default: false
  end
end
