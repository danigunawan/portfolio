ActionMailer::Base.prepend_view_path "#{ Market::Application.root }/app/views/mailers"

# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.raise_delivery_errors = true
# ActionMailer::Base.perform_deliveries = true
# ActionMailer::Base.smtp_settings = {
# 	enable_starttls_auto: true,
# 	:authentication => :plain,
# 	:address => "smtp.mailgun.org",
# 	:port => ENV['MAILGUN_PORT'],
# 	:domain => ENV['MAILGUN_DOMAIN'],
# 	:user_name => ENV['MAILGUN_USERNAME'],
# 	:password => ENV['MAILGUN_PASSWORD']
# }
