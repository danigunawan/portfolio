class PostsController < ApplicationController
	def show
		# impressionist(get_resource, "view", :unique => [:session_hash])
		super
	end

	private

	def resource_class
		@resource_class ||= current_site.posts
	end

	def collection_class
		@collection_class ||= current_site.posts
	end

	def post_params
		params.permit(:id)
	end
end
