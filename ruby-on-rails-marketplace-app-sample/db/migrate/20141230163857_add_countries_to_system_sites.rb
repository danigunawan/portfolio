class AddCountriesToSystemSites < ActiveRecord::Migration
  def change
	  create_table :listing_meta_locations_system_sites, id: false do |t|
	    t.belongs_to :site
	    t.belongs_to :country
	  end
  end
end
