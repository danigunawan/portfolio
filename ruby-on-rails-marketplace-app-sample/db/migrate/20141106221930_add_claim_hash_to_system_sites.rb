class AddClaimHashToSystemSites < ActiveRecord::Migration
  def change
    add_column :system_sites, :claim_hash, :string
  end
end
