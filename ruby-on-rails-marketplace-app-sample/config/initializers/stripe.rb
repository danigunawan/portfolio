# config/initializers/stripe.rb
#todo remove the key info from this file and have env variable
#todo recreate new API keys when do that
# if Rails.env == 'production'
#   Rails.configuration.stripe = {
#     :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
#     :secret_key      => ENV['STRIPE_SECRET_KEY']
#   }
# else
#   Rails.configuration.stripe = {
#     :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
#     :secret_key      => ENV['STRIPE_SECRET_KEY']
#   }
# end

# Stripe.api_key = Rails.configuration.stripe[:secret_key]
