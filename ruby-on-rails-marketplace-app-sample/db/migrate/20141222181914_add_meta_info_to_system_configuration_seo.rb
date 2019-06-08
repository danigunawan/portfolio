class AddMetaInfoToSystemConfigurationSeo < ActiveRecord::Migration
  def change
    add_column :system_configuration_seos, :host, :string
    add_column :system_configuration_seos, :title, :string
    add_column :system_configuration_seos, :description, :text
    add_column :system_configuration_seos, :keywords, :string

    add_index :system_configuration_seos, [:host]
  end
end
