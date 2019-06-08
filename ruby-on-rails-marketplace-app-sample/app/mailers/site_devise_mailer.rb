class SiteDeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

	def confirmation_instructions(record, token, opts={})
		opts[:subject] = "Please confirm your email address"
		opts = format_site_opts(record, opts)
		super
	end

	def reset_password_instructions(record, token, opts={})
		opts[:subject] = "Reset password instructions"
		opts = format_site_opts(record, opts)
		super
	end

	def unlock_instructions(record, token, opts={})
		opts[:subject] = "Account unlock instructions"
		opts = format_site_opts(record, opts)
		super
	end

	def password_change(record, opts={})
		opts[:subject] = "Your password has changed"
		opts = format_site_opts(record, opts)
		super
	end

	def email_changed(record, opts={})
		opts[:subject] = "Your email has changed"
		opts = format_site_opts(record, opts)
		super
	end

	private

	def format_site_opts(record, opts={})
		opts[:from] = "noreply@#{record.site.host}"
		opts[:reply_to] = "support@#{record.site.host}"
		opts[:subject] = "[#{ record.site.name }] #{opts[:subject]}"
		opts
	end
end
