class AddSiteToSystemExternalSubscriptions < ActiveRecord::Migration
  def change
    add_reference :system_external_subscriptions, :site, index: true
  end
end
