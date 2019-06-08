class CreateSystemExternalSubscribers < ActiveRecord::Migration
  def change
    create_table :system_external_subscribers do |t|

      t.timestamps
    end
  end
end
