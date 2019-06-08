class SupportTicket < ActiveRecord::Base
  belongs_to :user
  belongs_to :staff,
		class_name: "User"

	belongs_to :site
end
