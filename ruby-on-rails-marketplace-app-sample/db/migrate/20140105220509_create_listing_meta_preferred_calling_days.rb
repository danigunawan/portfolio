class CreateListingMetaPreferredCallingDays < ActiveRecord::Migration
  def change
    create_table :listing_meta_preferred_calling_days do |t|
      t.string :name
      t.boolean :published
      t.timestamps
    end
  end
end
