class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
			t.string   "stripe_id"
			t.string   "name"
			t.string   "interval"
			t.integer  "amount"
			t.string   "currency"
			t.integer  "interval_count"
			t.integer  "trial_period_days"
			t.text     "metadata"
			t.boolean  "active",            default: true
			t.boolean  "deleted",           default: false
      t.timestamps null: false
    end
  end
end
