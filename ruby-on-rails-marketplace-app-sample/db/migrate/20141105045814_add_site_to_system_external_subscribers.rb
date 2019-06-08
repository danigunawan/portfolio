class AddSiteToSystemExternalSubscribers < ActiveRecord::Migration
  def change
    add_reference :system_external_subscribers, :site, index: true
  end
end
