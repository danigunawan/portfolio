class SupportMailer < ApplicationMailer

	def help_support_email(support_ticket)
		@support_ticket = support_ticket

		mail to: "support@#{ support_ticket.site.host.downcase.gsub('www.','') }"
		mail from: "noreply@#{ support_ticket.site.host.downcase.gsub('www.','') }"
		# mail reply_to: "#{support_ticket.name} <#{ support_ticket.reply_to }>"
		mail subject: "[#{ support_ticket.site.name }] Ticket ##{ support_ticket.id }"
	end
end
