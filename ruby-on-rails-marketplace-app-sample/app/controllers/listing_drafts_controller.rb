class ListingDraftsController < ApplicationController
	respond_to :json

	def create
		# Store draft id to session variable on create if none exists.
		session[:listing_draft_id] ||= resource_class.create(listing_draft_params).id

		# Set :id to the sessions stored id or the newly created one for the update method to process the request as an update.
		params[:id] = session[:listing_draft_id]

		# Call on update to handle the normal update process.
		if get_resource && allowed? && get_resource.update(resource_params)
			render json: {status: 200}, status: 200
		end
	end

	private

	def resource_class
		@resource_class ||= current_user.listing_drafts if current_user
		@resource_class ||= current_site.listing_drafts
	end

	def collection_class
		@collection_class ||= current_user.listing_drafts if current_user
		@collection_class ||= current_site.listing_drafts
	end

	def listing_draft_params
		params[:listing] ||= {}

		# Clean up draft store to stop erroneous input bloat.
		params[:listing][:draft] = {
			contact_name: params[:listing][:contact_name],
			contact_email: params[:listing][:contact_email],
			email: params[:listing][:email] || params[:listing][:contact_email],
			phone: params[:listing][:contact_phone],
			category: params[:listing][:category] && params[:listing][:category][:name] ? params[:listing][:category][:name] : params[:listing][:category],
			address: params[:listing][:address] && params[:listing][:address][:formatted_address] ? params[:listing][:address][:formatted_address] : params[:listing][:address]
		}.to_json.to_s

		# Meta details about the user and the current draft being updated.
		params[:listing][:location] ||= location.to_json
		params[:listing][:ip_address] ||= request.remote_ip

		# Hard set variables.
		params[:listing][:user_id] = current_user ? current_user.id : nil
		params[:listing][:site_id] = current_site.id

		# headline, contact_name, contact_phone, address, photos, youtube_url, category_attributes, draft

		params.require(:listing).permit(:draft, :user_id, :site_id, :location, :ip_address)
	end
end
