class AddRecommendedToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :recommended, :boolean, default: false
  end
end
