class AddBoostIntervalToListing < ActiveRecord::Migration
  def change
    add_reference :listings, :boost_interval, index: true, foreign_key: true
  end
end
