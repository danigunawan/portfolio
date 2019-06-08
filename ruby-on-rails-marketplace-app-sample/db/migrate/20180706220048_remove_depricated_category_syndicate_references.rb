class RemoveDepricatedCategorySyndicateReferences < ActiveRecord::Migration
  def change
    remove_column :category_syndicates, :category_source_id
    remove_column :category_syndicates, :category_destination_id
  end
end
