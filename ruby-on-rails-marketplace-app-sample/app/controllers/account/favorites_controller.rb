class Account::FavoritesController < ApplicationController
	before_action :authenticate_user!

	def after_create_actions
		flash[:notice_success] = "<strong>Listing saved to favorites!</strong>"
		redirect_to(:back) and return false
	end

	def after_destroy_actions
		flash[:notice_success] = "<strong>Listing removed from favorites!</strong>"
		redirect_to(:back) and return false
	end

	# ==========================================
	# Helper Methods
	# ==========================================

	private

	def resource_class
		@resource_class ||= current_user.favorites
	end

	def collection_class
		@collection_class ||= current_user.favorites.order(created_at: :desc)
	end

	def favorite_params
		params.permit(:listing_id)
	end
end
