class Account::BillingsController < ApplicationController
	before_action :authenticate_user!
	# Destroy card

	# def destroy
	# 	card = current_user.customer.sources.select { |i| i.id.index(params[:id]) }.first if !params[:id].blank?
	# 	flash[:notice_success] = "<strong>Card Removed!</strong> We have sucessfully removed your payment card. <a ng-click=\"SessionService.openModal(\'help.html\')\"><strong>Billing Support</strong></a>" if card
	# 	flash[:notice_error] = "<strong>Error Deleting Card!</strong> Something went wrong we tried to delete your card. <a ng-click=\"SessionService.openModal(\'help.html\')\"><strong>Billing Support</strong></a>" if !card
	# 	card.delete if card
	# 	redirect_to account_billing_path and return
	# end
	#

	def after_update_actions
		if params[:use_existing_card] && current_user.customer && !current_user.customer.sources.blank?
			flash[:notice_success] = "<strong>Plan Updated!</strong> Thank you for updating your subscription to the <strong>#{ current_user.plan.name } Plan</strong>."
			respond_to do |format|
				format.html { redirect_to :back }
				format.json { head :no_content }
			end and return
		elsif !params[:stripe_token].blank?
			# Only using the one card at a time model so all cards will be set as primary.
			current_user.add_card(params[:stripe_token], primary: true)
			current_user.save
			flash[:notice_success] = "<strong>Plan Updated!</strong> Thank you for updating your subscription and billing info."
			respond_to do |format|
				format.html { redirect_to :back }
				format.json { head :no_content }
			end and return
		end

		respond_to do |format|
			format.html { redirect_to :back }
			format.json { head :error }
		end and return
	end

	private

	def resource_class
		@resource_class ||= current_user
	end

	def collection_class
		@collection_class ||= current_user
	end

	def billing_params
		# Restrict plan id to only the active plans for the current site.
		if !params[:plan_id].blank? && current_site.plans.where(active:true, id:params[:plan_id]).first
			params[:plan_id] = current_site.plans.where(active:true, id:params[:plan_id]).first.id
		else
			params[:plan_id] = nil
		end

		params.permit(:plan_id)
	end
end
