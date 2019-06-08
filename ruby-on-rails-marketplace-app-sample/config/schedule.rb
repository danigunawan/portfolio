# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

unless ENV['RAILS_ENV'] == 'test'
  every 1.minutes do
    # runner "Channel.schedule_channels_for_publishing"
    rake "jobs:workoff"
  end
	#
  # every 3.hours do
  #   # runner "User.verify_billing_for_all_accounts"
  #   # rake "jobs:workoff"
  # end
	#
  # every 5.minutes do
  #   # runner "Plan.sync_with_stripe"
  #   # rake "jobs:workoff"
  # end
end
