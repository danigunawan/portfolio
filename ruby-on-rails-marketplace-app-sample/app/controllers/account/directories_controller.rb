class Account::DirectoriesController < ApplicationController
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
			flash[:notice_success] = "<strong>Directory Info Updated!</strong> Thank you for updating your information."
			redirect_to action:"edit" and return false
		else
			flash[:notice_error] = "<strong>Directory Info Not Updated!</strong> Please correct the problems below."
			return true
		end
  end

	private

	def resource_class
		@resource_class ||= current_user.business
	end

	def collection_class
		@collection_class ||= current_user.business
	end

	def directory_params
		params.require(:directory).permit(:enable_directory)
	end
end
