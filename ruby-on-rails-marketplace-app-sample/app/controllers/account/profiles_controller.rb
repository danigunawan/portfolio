class Account::ProfilesController < ApplicationController
	before_action :authenticate_user!

	# PATCH/PUT /{plural_resource_name}/1
	def update
		if get_resource && allowed? && get_resource.update_with_password(resource_params)
			respond_to do |format|
				format.html { render :show }
				format.json { render json: get_resource, status: :success }
			end if after_update_actions
		else
			respond_to do |format|
				format.html { render :edit }
				format.json { render json: get_resource.errors, status: :unprocessable_entity }
			end if after_update_actions
		end
	end

	def after_update_actions
		if get_resource.errors.blank?
			flash[:notice_success] = "<strong>Profile Updated!</strong> Thank you for updating your information."
			redirect_to action:"edit" and return false
		else
			flash[:notice_error] = "<strong>Profile Not Updated!</strong> Please correct the problems below."
			return true
		end
  end

	private

	def resource_class
		@resource_class ||= current_user
	end

	def collection_class
		@collection_class ||= current_user
	end

	def profile_params
		params.require(:profile).permit(:current_password, :password, :password_confirmation, :first_name, :last_name, :email, :contact_email, :contact_phone, :activity_notifications, :favorite_listing_notifications, :saved_search_notifications)
	end
end
