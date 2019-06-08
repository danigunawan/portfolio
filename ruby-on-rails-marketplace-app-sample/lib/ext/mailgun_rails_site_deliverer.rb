module MailgunRails
	class SiteDeliverer < Deliverer

		def domain
			site.env['MAILGUN_DOMAIN']
		end

		def api_key
			site.env['MAILGUN_API_KEY']
		end

		attr_accessor :site

		def deliver!(rails_message)
			self.site = Site.load_from_host(rails_message.from.first.gsub(/.*@/,''))
			rails_message.from = "#{ self.site.name } <noreply@#{self.site.host.gsub('www.','')}>"
			rails_message.reply_to = "#{ self.site.name } Support <support@#{self.site.host.gsub('www.','')}>" if rails_message.reply_to.blank?
			response = mailgun_client.send_message build_mailgun_message_for(rails_message)
			if response.code == 200
				begin
					mailgun_message_id = JSON.parse(response.to_str)["id"]
					rails_message.message_id = mailgun_message_id
				rescue JSON::ParserError => e
					print e
				end
			end

			response
		end

		private
	end
end

ActionMailer::Base.add_delivery_method :site_deliverer, MailgunRails::SiteDeliverer
