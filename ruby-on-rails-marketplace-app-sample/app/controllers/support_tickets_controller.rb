class SupportTicketsController < ApplicationController
	def after_create_actions
		SupportMailer.help_support_email(get_resource).deliver_later
		redirect_to :back and return false
	end


  private
    def resource_class
      @resource_class ||= current_site.support_tickets
    end

    def collection_class
      @collection_class ||= current_site.support_tickets
    end

    def support_ticket_params
			params[:support_ticket][:user_id] = nil
			params[:support_ticket][:user_id] = current_user.id if current_user
      params.require(:support_ticket).permit(:name, :reply_to, :message, :user_id)
    end

    def query_params
      params.permit(:id)
    end

    def allowed?
      return true
    end
end
