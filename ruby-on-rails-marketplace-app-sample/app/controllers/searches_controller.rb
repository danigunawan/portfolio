class SearchesController < ApplicationController

	# ==========================================
	# Helper Methods
	# ==========================================
	# Query param based request.

	def index
		redirect_to search_path and return
	end

	def query
		slugs = params[:slug].downcase.split('/')

		# Load category from slug
		category = current_site.categories.where('lower(name) LIKE ?', slugs[0].gsub('-for-sale','').gsub('-',' ')).first
		params[:category_id] = category.id if category

		# Load keywords from after category
		keywords = slugs[1] if slugs && slugs[1]
		params[:keywords] = keywords if keywords

		get_resource

		respond_to do |format|
			format.html { render :show }
			format.json { render json: get_resource, status: :success }
		end
	end

	private

	def resource_class
		normalized_params = Search.normalize_params(search_params, Search.new)
		normalized_params[:site_id] = current_site.id
		@resource_class ||= current_site.searches.find_or_create_by(normalized_params)

		# Set lat lon for query results (not persisted to db)
		# @resource_class.latitude = params[:latitude] if params[:latitude]
		# @resource_class.longitude = params[:longitude] if params[:longitude]

		# Set the search bounds for querying.
		@resource_class.bounds = params[:bounds] if params[:bounds]

		@resource_class
	end

	def collection_class
		@collection_class ||= current_site.searches
	end

	def search_params
		params[:category_id] = nil if !current_site.categories.where(id:params[:category_id]).first
		params.permit(:category_id, :keywords, :location, :site_id, :latitude, :longitude)
	end
end
