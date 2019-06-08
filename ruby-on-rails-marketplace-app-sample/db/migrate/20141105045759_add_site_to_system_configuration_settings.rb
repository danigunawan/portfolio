class AddSiteToSystemConfigurationSettings < ActiveRecord::Migration
  def change
    add_reference :system_configuration_settings, :site, index: true
  end
end
