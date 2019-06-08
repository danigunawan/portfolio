class Users::ConfirmationsController < Devise::ConfirmationsController
  # here we need to skip the automatic authentication based on current session for the following two actions
  # edit: shows the reset password form. need to skip, otherwise it will go directly to root
  # update: updates the password, need to skip otherwise it won't even reset if already logged in
  # skip_before_filter :require_no_authentication, :only => [:edit, :update]

	# POST /resource/confirmation
  def create
		self.resource = resource_class.send_confirmation_instructions(resource_params)
		yield resource if block_given?

		if successfully_sent?(resource)
			flash[:notice_success] = "<strong>Confirmation instructions sent to your email!</strong> Still need help? <a ng-click='SessionService.openModal(\"help.html\")'>Get in touch</a>."
			redirect_to(:back) and return
		else
			respond_with(resource)
		end
	end

	def resource_params
		params[:user] ||= {}
		params[:user][:email] = current_user.email if current_user
		super
	end
end
