class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :add_account
  before_filter :set_site_id, :set_username

  private

  def sign_up_params
    params.require(:user).permit(:site_id, :first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:site_id, :first_name, :last_name, :username, :email, :password, :password_confirmation, :current_password)
  end

  protected

  def add_account
		# if resource.persisted? # user is created successfuly
      # resource.plan = session[:plan] if session[:plan]
    # end
  end

	def set_site_id
		params[:user] ||= {}
		params[:user][:site_id] = current_site.id
	end

	def set_username
		params[:user] ||= {}
		params[:user][:username] = nil
		params[:user][:username] = User.format_username_with_site(params[:user][:email], current_site) if params[:user][:email]
	end
end
