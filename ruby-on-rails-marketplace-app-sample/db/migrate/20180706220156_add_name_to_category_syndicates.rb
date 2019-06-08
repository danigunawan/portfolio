class AddNameToCategorySyndicates < ActiveRecord::Migration
  def change
    add_column :category_syndicates, :name, :string
  end
end
