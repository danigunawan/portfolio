class CreateSystemConfigurationSeos < ActiveRecord::Migration
  def change
    create_table :system_configuration_seos do |t|

      t.timestamps
    end
  end
end
