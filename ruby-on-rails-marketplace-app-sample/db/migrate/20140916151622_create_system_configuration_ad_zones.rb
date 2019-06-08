class CreateSystemConfigurationAdZones < ActiveRecord::Migration
  def change
    create_table :system_configuration_ad_zones do |t|

      t.timestamps
    end
  end
end
