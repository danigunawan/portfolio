class CreateSystemExternalSubscriptions < ActiveRecord::Migration
  def change
    create_table :system_external_subscriptions do |t|

      t.timestamps
    end
  end
end
