class AddSiteToPlans < ActiveRecord::Migration
  def change
    add_reference :plans, :site, index: true, foreign_key: true
  end
end
