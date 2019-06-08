class AddBoostLevelToListing < ActiveRecord::Migration
  def change
    add_reference :listings, :boost_level, index: true, foreign_key: true
  end
end
