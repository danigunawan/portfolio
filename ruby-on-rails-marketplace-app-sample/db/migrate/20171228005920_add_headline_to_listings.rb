class AddHeadlineToListings < ActiveRecord::Migration
  def change
    add_column :listings, :headline, :string
  end
end
