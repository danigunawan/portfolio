class AddEnvToSites < ActiveRecord::Migration
  def change
    add_column :sites, :env, :text
  end
end
