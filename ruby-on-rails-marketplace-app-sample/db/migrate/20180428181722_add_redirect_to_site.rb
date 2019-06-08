class AddRedirectToSite < ActiveRecord::Migration
  def change
    add_reference :sites, :redirect, index: true
  end
end
