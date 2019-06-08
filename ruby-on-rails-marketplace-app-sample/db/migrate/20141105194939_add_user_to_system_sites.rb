class AddUserToSystemSites < ActiveRecord::Migration
  def change
    add_reference :system_sites, :user, index: true
  end
end
