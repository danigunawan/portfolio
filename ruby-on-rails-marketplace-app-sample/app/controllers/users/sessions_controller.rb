class Users::SessionsController < Devise::SessionsController
	before_filter :set_username
	
  # DELETE /resource/sign_out
  def destroy
    super
    flash.delete(:notice)
  end

	# POST /resource/sign_in
  def create
		# TODO: DOES NOT WORK!!! https://github.com/plataformatec/devise/issues/4079
		# This is a patch that resorts to the manual login sign in.
		# Needs to be updated!!!!
		self.resource = User.find_for_authentication(username: params[:user][:username])
		self.resource = warden.authenticate!(auth_options) if !resource or !resource.valid_password?(params[:user][:password])
    sign_in(resource_name, resource) if resource.valid_password?(params[:user][:password])
    yield resource if block_given?
		respond_with resource, location: after_sign_in_path_for(resource)
  end

	private

	def set_username
		params[:user] ||= {}
		params[:user][:username] = nil
		params[:user][:username] = User.format_username_with_site(params[:user][:email], current_site) if params[:user][:email]
		params[:user].delete :email
	end

	def sign_in_params
		params.require(:user).permit(:username, :password, :remember_me)
	end
end
