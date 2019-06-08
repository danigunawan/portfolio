class MailersController < ApplicationController

	def create_support_ticket
		support_ticket = SupportTicket.new(support_ticket_params)

		support_ticket.site = current_site
		support_ticket.user = current_user
		support_ticket.page = request.original_url
		support_ticket.save

		SupportMailer.help_support_email(support_ticket).deliver_later

		flash[:notice_success] = "<strong>We've received your support request!</strong> We'll try to get back with you within 1 business day."

		redirect_to request.referer and return
	end

	private

	def support_ticket_params
		params.require(:support_ticket).permit(:reply_to, :name, :message)
	end
end
