class Account::PostsController < ApplicationController
	before_action :authenticate_user!

	def after_update_actions
		@post.photos = []
		@post.photos = params[:post][:photo_ids].map { |i| current_site.photos.where(id: i).first } if params[:post][:photo_ids]
		@post.save(validate:false)

		flash[:notice_success] = "<strong>Post updated!</strong> Check out your post <a href='#{ post_path(@post) }' target='_blank'>here</a>."

		redirect_to account_posts_path and return false
	end

	def after_create_actions
		@post.photos = params[:post][:photo_ids].map { |i| current_site.photos.where(id: i).first } if params[:post][:photo_ids]
		@post.save(validate:false)

		flash[:notice_success] = "<strong>Post created!</strong> Check out your post <a href='#{ post_path(@post) }' target='_blank'>here</a>."

		redirect_to account_posts_path and return false
	end

	def after_destroy_actions
		flash[:notice_success] = "<strong>Post deleted!</strong>"
		redirect_to account_posts_path and return false
	end

	def after_destroy_actions
		flash[:notice_success] = "<strong>Post deleted!</strong>"
		redirect_to account_posts_path and return false
	end

	# ==========================================
	# Helper Methods
	# ==========================================

	private

	def resource_class
		@resource_class ||= current_user.posts
	end

	def collection_class
		@collection_class ||= current_user.posts.order(created_at: :desc)
	end

	def post_params
		params[:post][:site_id] = current_site.id
		params[:post][:edited_at] = Time.now
		params[:post][:publish_at] ||= Time.now
		params.require(:post).permit(:site_id, :edited_at, :title, :body, :featured_photo_url, :publish_at)
	end
end
