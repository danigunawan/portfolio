class AddBoostPlanIdToListing < ActiveRecord::Migration
  def change
    add_column :listings, :boost_plan_id, :string
  end
end
