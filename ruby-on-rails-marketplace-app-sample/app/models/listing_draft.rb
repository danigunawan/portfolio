require 'slack-notifier'

class ListingDraft < ActiveRecord::Base
	# Paper trail for tracking states across draft updates.
	has_paper_trail

	after_save :send_slack_notification

  belongs_to :user
  belongs_to :site
  belongs_to :listing
	serialize :draft, JSON

	def send_slack_notification
		notifier = Slack::Notifier.new "https://hooks.slack.com/services/**************"
		message =
			"*Lead Id:* #{ id }\n" +
			"*Site:* #{ site ? site.name : 'none' }\n" +
			"*User:* #{ user ? user.full_name : 'guest' }\n" +
			"*Email:* #{ user ? user.email : 'guest' }\n" +
			"*Draft:* \n" +
				"\t*contact_name:* #{ JSON.parse(draft)["contact_name"] }\n" +
				"\t*contact_email:* #{ JSON.parse(draft)["contact_email"] }\n" +
				"\t*email:* #{ JSON.parse(draft)["email"] }\n" +
				"\t*phone:* #{ JSON.parse(draft)["phone"] }\n" +
				"\t*category:* #{ JSON.parse(draft)["category"] }\n" +
				"\t*address:* #{ JSON.parse(draft)["address"] }\n" +
			"*Location:* #{ location }"

		notifier.ping message, channel: "#marketing"
	end
end
