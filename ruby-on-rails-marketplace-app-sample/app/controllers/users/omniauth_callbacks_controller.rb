class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    policy_callback(:facebook)
  end

  def twitter
    policy_callback(:twitter)
  end

  def google_oauth2
    policy_callback(:google_oauth2)
  end

  def linkedin
    policy_callback(:linkedin)
  end

  def slack
    policy_callback(:slack)
  end

  def policy_callback(provider)
    @policy = "#{ provider }_policy".classify.constantize.new(env["omniauth.auth"])
    @user = Account.find_or_create_by_policy(@policy, self.current_user).user
    sign_in_and_redirect @user, :event => :authentication
  end
end