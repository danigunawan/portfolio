class CreateSystemConfigurationSettings < ActiveRecord::Migration
  def change
    create_table :system_configuration_settings do |t|
    	t.string :type
    	
    	t.string :key
    	t.string :value
    	t.timestamps
    end

    add_index :system_configuration_settings, :key
  end
end
