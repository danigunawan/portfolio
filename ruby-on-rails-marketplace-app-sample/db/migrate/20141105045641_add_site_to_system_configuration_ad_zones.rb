class AddSiteToSystemConfigurationAdZones < ActiveRecord::Migration
  def change
    add_reference :system_configuration_ad_zones, :site, index: true
  end
end
