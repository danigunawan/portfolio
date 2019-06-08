class AddSiteToSystemConfigurationSeos < ActiveRecord::Migration
  def change
    add_reference :system_configuration_seos, :site, index: true
  end
end
