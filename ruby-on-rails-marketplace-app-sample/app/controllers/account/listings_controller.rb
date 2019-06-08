class Account::ListingsController < ApplicationController
	before_action :authenticate_user!

	def after_update_actions
		connect_with_listing_draft

		@listing.category_attribute_values_from_params(params[:listing][:category_attributes])
		@listing.price_unit = @listing.price_unit_attribute.category_attribute_values.where(id:params[:listing][:price_unit_id]).first if @listing.price_unit_attribute
		@listing.photos = []
		@listing.photos = params[:listing][:photo_ids].map { |i| current_user.photos.where(id: i).first } if params[:listing][:photo_ids]
		@listing.save(validate:false)

		flash[:notice_success] = "<strong>Listing updated!</strong> Check out your listing <a href='#{ listing_path(@listing) }' target='_blank'>here</a>."

		# current_user.enforce_billing_and_save
		# redirect_to account_listings_path.add_param_to_uri('modal','subscription') and return false if @listing.reload && !@listing.billing_active

		redirect_to account_listings_path and return false
	end

	def after_create_actions
		connect_with_listing_draft

		@listing.category_attribute_values_from_params(params[:listing][:category_attributes])
		@listing.price_unit = @listing.price_unit_attribute.category_attribute_values.where(id:params[:listing][:price_unit_id]).first if @listing.price_unit_attribute
		@listing.photos = params[:listing][:photo_ids].map { |i| current_user.photos.where(id: i).first } if params[:listing][:photo_ids]
		@listing.save(validate:false)

		flash[:notice_success] = "<strong>Listing created!</strong> Check out your listing <a href='#{ listing_path(@listing) }' target='_blank'>here</a>."

		# current_user.enforce_billing_and_save
		# redirect_to account_listings_path.add_param_to_uri('modal','subscription') and return false if @listing.reload && !@listing.billing_active

		redirect_to account_listings_path and return false
	end

	def after_destroy_actions
		flash[:notice_success] = "<strong>Listing deleted!</strong>"
		redirect_to account_listings_path and return false
	end

	# ==========================================
	# Helper Actions
	# ==========================================

	def renew
		if allowed? && get_resource
			if get_resource.is_a? ActiveRecord::Associations::CollectionProxy
				get_resource.update_all(edited_at:Time.now)
				flash[:notice_success] = "<strong>Listings renewed!</strong> Thanks for updating your listings!"
			else
				get_resource.update(edited_at:Time.now)
				flash[:notice_success] = "<strong>Listing renewed!</strong> Check out your listing <a href='#{ listing_path(@listing) }' target='_blank'>here</a>."
			end
		end
		redirect_to account_listings_path and return
	end

	# ==========================================
	# Helper Methods
	# ==========================================

	private

	def connect_with_listing_draft
		# Check if a listing draft exists.
		listing_draft = ListingDraft.where(id:session[:listing_draft_id]).first if session[:listing_draft_id]
		listing_draft.update(listing_id: @listing.id) if listing_draft && @listing && @listing.id

		# Reset session tracker for listing draft controller
		session[:listing_draft_id] = nil
	end

	def resource_class
		@resource_class ||= current_user.listings
	end

	def collection_class
		@collection_class ||= current_user.listings.order(created_at: :desc)
	end

	def listing_params
		params[:listing][:transportation_available] ||= false
		params[:listing][:site_id] = current_site.id
		params[:listing][:edited_at] = Time.now
		params[:listing][:boost_interval_id] ||= current_site.boost_intervals.find_or_create_by(term:0).id
		params[:listing][:boost_level_id] ||= current_site.boost_levels.find_or_create_by(level:0).id
		params.require(:listing).permit(:site_id, :edited_at, :contact_name, :contact_phone, :address, :headline, :description, :price, :youtube_url, :category_id, :transportation_available, :boost_interval_id, :boost_level_id)
	end
end
