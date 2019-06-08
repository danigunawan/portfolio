class CreateListingMetaClassReferences < ActiveRecord::Migration
  def change
    create_table :listing_meta_class_references do |t|
      t.string :class_reference_name
      t.boolean :published
      t.timestamps
    end
  end
end
