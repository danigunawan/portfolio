class PlansController < ApplicationController
  private
    def resource_class
      @resource_class ||= current_site.plans
    end

    def collection_class
      @collection_class ||= current_site.plans
    end

    def plan_params
      params.require(:plan).permit(:name, :id)
    end

    def query_params
      params.permit(:plan_id, :name)
    end

    def allowed?
      return true
    end
end
