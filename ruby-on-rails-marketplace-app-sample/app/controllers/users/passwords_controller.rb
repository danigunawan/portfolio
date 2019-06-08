class Users::PasswordsController < Devise::PasswordsController
  # here we need to skip the automatic authentication based on current session for the following two actions
  # edit: shows the reset password form. need to skip, otherwise it will go directly to root
  # update: updates the password, need to skip otherwise it won't even reset if already logged in
  # skip_before_filter :require_no_authentication, :only => [:edit, :update]
end
