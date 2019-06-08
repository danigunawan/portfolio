class AddSlugToBusinessTags < ActiveRecord::Migration
  def change
    add_column :business_tags, :slug, :string, index:true
  end
end
