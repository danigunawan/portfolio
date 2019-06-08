class PhotosController < ApplicationController

	# Set format to html unless client requires a specific format
  # Works on Rails 3.0.9
  def default_format
    request.format = "json" unless params[:format]
  end

  private
    def resource_class
			@resource_class ||= current_user.photos if current_user
			@resource_class ||= current_site.photos
    end

    def collection_class
      @collection_class ||= current_user.photos if current_user
			@collection_class ||= current_site.photos
    end

    def photo_params
      params.delete :site_id
			params[:photo] ||= {}
			params[:photo][:site_id] = current_site.id
			params.require(:photo).permit(:uploaded, :title, :description, :site_id)
    end

    def query_params
      # this assumes that an category belongs to an artist and has an :artist_id
      # allowing us to filter by this
      params.permit(:type)
    end

    def allowed?
    	return true
    end
end
