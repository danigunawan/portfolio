class CreateBusinessTags < ActiveRecord::Migration
  def change
    create_table :business_tags do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :business_tags_businesses, id:false do |t|
      t.belongs_to :business, index:true
      t.belongs_to :business_tag, index:true
    end
  end
end
