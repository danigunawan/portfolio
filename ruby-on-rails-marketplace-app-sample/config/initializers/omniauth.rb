# include ApplicationHelper
#
# OmniAuth.config.logger = Rails.logger
#
# SETUP_PROC = lambda do |env|
# 	request = Rack::Request.new(env)
# 	current_site = Site.load_from_request(request)
#
#   # Note client_id & client_secret for Facebook
#   env['omniauth.strategy'].options[:client_id] = current_site.env :FACEBOOK_APP_ID
#   env['omniauth.strategy'].options[:client_secret] = current_site.env :FACEBOOK_APP_SECRET
#
#   # Update Omni Auth Config
# 	OmniAuth.config.full_host = current_site.env :OMNIAUTH_FULL_HOST
# end
#
# # Note the below block is different for a Rails app
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, setup: SETUP_PROC
# end
