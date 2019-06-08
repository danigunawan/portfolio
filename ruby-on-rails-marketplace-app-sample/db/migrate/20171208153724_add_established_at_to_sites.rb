class AddEstablishedAtToSites < ActiveRecord::Migration
  def change
    add_column :sites, :established_at, :datetime
  end
end
