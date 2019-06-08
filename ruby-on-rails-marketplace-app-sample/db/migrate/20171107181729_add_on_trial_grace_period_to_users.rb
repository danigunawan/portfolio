class AddOnTrialGracePeriodToUsers < ActiveRecord::Migration
  def change
    add_column :users, :on_trial_grace_period, :boolean, default: false
  end
end
