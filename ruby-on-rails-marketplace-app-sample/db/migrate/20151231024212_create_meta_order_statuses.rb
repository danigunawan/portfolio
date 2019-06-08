class CreateMetaOrderStatuses < ActiveRecord::Migration
  def change
    create_table :meta_order_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
