class ListingsController < ApplicationController
	def show
		impressionist(get_resource, "detailed", :unique => [:session_hash])
		super
	end

	# POST Listing contact form handler.
	def contact
		redirect_to "/" and return if !get_resource

		listing_message = get_resource.listing_messages.create(listing_message_params)

		# Only send messages if the sender is less than 900 miles away.
		if !listing_message.block? #&& listing_message.listing.distance_from([listing_message.latitude, listing_message.longitude]).ceil < 500
			ListingMailer.listing_message(listing_message).deliver_now
			listing_message.update(sent:true)
		end
		flash[:notice_success] = "<strong>Thank you!</strong> The seller will need to get back with you once they read your message!"

		respond_to do |format|
			format.html { redirect_to listing_path(get_resource) }
			format.json { redirect_to listing_path(get_resource) }
		end
	end

	private

	def resource_class
		@resource_class ||= Listing
	end

	def collection_class
		@collection_class ||= current_site.listings
	end

	def listing_params
		params.permit(:id)
	end

	def listing_message_params
		params[:listing_message] ||= {}
		params[:listing_message][:user_id] = (current_user ? current_user.id : nil)
		params[:listing_message][:from_ip_address] = request.remote_ip
		params.require(:listing_message).permit(:from_email, :name, :phone, :body, :user_id, :from_ip_address)
	end
end
