class AddVisitsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :visits, :integer, :default => 0
  end
end
