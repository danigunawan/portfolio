class ListingMailer < ApplicationMailer

	def listing_message(listing_message)
		@listing_message = listing_message

		mail from: "#{ listing_message.listing.site.name } <noreply@#{ listing_message.listing.site.host.downcase }>"
		mail to: "#{listing_message.listing.user.full_name } <#{ listing_message.listing.user.email }>"
		mail reply_to: "#{listing_message.name} <#{ listing_message.from_email }>"
		mail subject: "#{ listing_message.name } is interested in your listing..."
	end
end
