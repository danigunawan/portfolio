class CategoriesController < ApplicationController

  private
    # Returns the resource from the created instance variable
    # @return [Object]
    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    def resource_class
      site ||= Site.where(id:params[:site_id].to_i).first
      site ||= current_site
      @resource_class ||= site.categories
    end

    def collection_class
      site ||= Site.where(id:params[:site_id].to_i).first
      site ||= current_site
      @collection_class ||= site.categories
    end

    def category_params
      params.require(:category).permit(:name, :id, :parent_category_id, :promoted)
    end

    def query_params
      # this assumes that an category belongs to an artist and has an :artist_id
      # allowing us to filter by this
      params.permit(:category_id, :name, :updated_at, :site_id)
    end

    def allowed?
      return false if get_resource and get_resource.locked?
      return true
    end
end
