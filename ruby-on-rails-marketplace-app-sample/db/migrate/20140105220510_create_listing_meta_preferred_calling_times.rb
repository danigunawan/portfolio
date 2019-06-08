class CreateListingMetaPreferredCallingTimes < ActiveRecord::Migration
  def change
    create_table :listing_meta_preferred_calling_times do |t|
      t.string :name
      t.boolean :published
      t.time :time_start
      t.time :time_end
      t.timestamps
    end
  end
end
