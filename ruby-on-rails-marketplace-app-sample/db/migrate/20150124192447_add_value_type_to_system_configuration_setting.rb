class AddValueTypeToSystemConfigurationSetting < ActiveRecord::Migration
  def change
    add_reference :system_configuration_settings, :value_type, index: true
  end
end
