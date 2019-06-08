class AddIpAddressToListingDrafts < ActiveRecord::Migration
  def change
    add_column :listing_drafts, :ip_address, :string
  end
end
