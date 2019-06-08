class Account::SavedSearchesController < ApplicationController
	before_action :authenticate_user!

	def after_create_actions
		flash[:notice_success] = "<strong>Search saved!</strong>"
		redirect_to(:back) and return false
	end

	def after_destroy_actions
		flash[:notice_success] = "<strong>Listing deleted!</strong>"
		redirect_to(:back) and return false
	end

	# ==========================================
	# Helper Methods
	# ==========================================

	private

	def resource_class
		@resource_class ||= current_user.saved_searches
	end

	def collection_class
		@collection_class ||= current_user.saved_searches.order(created_at: :desc)
	end

	def saved_search_params
		params.require(:saved_search).permit(:search_id)
	end
end
