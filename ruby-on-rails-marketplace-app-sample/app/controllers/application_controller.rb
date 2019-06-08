class ApplicationController < ActionController::Base

	# ============================================================================
	#                  F I L T E R S  &  C O N F I G U R A T I O N
	# ============================================================================

	respond_to :json, :html

	# before_action :set_resource, only: [:destroy, :show, :update]
	before_filter :track_impression

	before_filter :load_current_site, :default_format, :set_csrf_cookie_for_ng, :prepend_template_file_resolver, :set_paper_trail_whodunnit
	after_filter :store_location

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to main_app.root_path, :alert => exception.message
	end

	# ============================================================================
	#                          C R U D  M E T H O D S
	# ============================================================================

	# GET /{plural_resource_name}
	def index
		plural_resource_name = "@#{resource_name.pluralize}"
		params[:page] = params[:page].gsub(/\D/, '').to_i if params[:page]
		params[:page_size] = params[:page_size].gsub(/\D/, '').to_i if params[:page_size]
		resources = collection_class.where(query_params).paginate(:page => params[:page], :per_page => params[:page_size])
		@count = resources.count
		params[:page] ||= 1
		params[:page_size] ||= @count

		instance_variable_set(plural_resource_name, resources)
		respond_with instance_variable_get(plural_resource_name)
	end

	# ----------------------------------------------------------------------------
	#                               C R E A T E
	# ----------------------------------------------------------------------------

	def new
		set_resource(resource_class.new) if allowed?
	end

	# POST /{plural_resource_name}
	def create
		set_resource(resource_class.new(resource_params)) if allowed?

		if get_resource.save
			render :show, status: :created if after_create_actions
		else
			render json: get_resource.errors, status: :unprocessable_entity
		end
	end

	def after_create_actions
		# post update callbacks for custom work
		return true
	end

	# ----------------------------------------------------------------------------
	#                                 R E A D
	# ----------------------------------------------------------------------------

	# GET /{plural_resource_name}/1
	def show
		respond_with get_resource
	end

	# ----------------------------------------------------------------------------
	#                              U P D A T E
	# ----------------------------------------------------------------------------

	def edit
		get_resource
	end

	# PATCH/PUT /{plural_resource_name}/1
	def update
		if get_resource && allowed? && get_resource.update(resource_params)
			respond_to do |format|
				render :show and return
			end if after_update_actions
		else
			respond_to do |format|
				format.html { render :edit }
				format.json { render json: get_resource.errors, status: :unprocessable_entity }
			end
		end
	end

	def after_update_actions
		# post update callbacks for custom work.
		return true
	end

	# ----------------------------------------------------------------------------
	#                             D E S T R O Y
	# ----------------------------------------------------------------------------

	# DELETE /{plural_resource_name}/1
	def destroy
		get_resource.destroy if allowed?
		head :no_content if after_destroy_actions
	end

	# ============================================================================
	#                     F I L T E R  M E T H O D S
	# ============================================================================

	def track_impression
		impressionist(current_site, "user", :unique => [:session_hash]) if current_site
	end

	def prepend_template_file_resolver
		prepend_view_path TemplateFile.resolver(site_id: current_site.id)
	end

	# Set format to html unless client requires a specific format
	# Works on Rails 3.0.9
	def default_format
		request.format = "html" unless params[:format]
	end

	def set_csrf_cookie_for_ng
		cookies['XCSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
	end

	# Method: load_current_site
	# Description: A pre action filter for redirecting undefined sites.
	def load_current_site
		render nothing: true, status: 404 and return if not current_site or !current_site.active
		if current_site.redirect
			redirect_to "http://#{ current_site.redirect.host }#{ request.fullpath }", :status => 301 and return
		end
		current_site.initialize_environment
	end


	# ============================================================================
	#                         H E L P E R  M E T H O D S
	# ============================================================================

	# Method: current_site
	# Description: A global helper method for returning the current site for this request. Also works as
	#							a template helper.
	def current_site
		return @current_site ||= Site.where(public_key:params[:sid]).first if params[:sid] and can?(:manage, Site.where(public_key:params[:sid]))
		@current_site ||= Site.load_from_host(request.host)
	end
	helper_method :current_site

	def location
		return nil
	end

	def count
		@count = @collection_class.count
	end

	# ============================================================================
	#                 I N T E R N A L  H E L P E R  M E T H O D S
	# ============================================================================

	private

	# The singular name for the resource class based on the controller
	# @return [String]
	def resource_name
		@resource_name ||= self.controller_name.singularize
	end

	# Only allow a trusted parameter "white list" through.
	# If a single resource is loaded for #create or #update,
	# then the controller for the resource must implement
	# the method "#{resource_name}_params" to limit permitted
	# parameters for the individual model.
	def resource_params
		@resource_params ||= self.send("#{resource_name}_params")
	end

	# Returns the allowed parameters for searching
	# Override this method in each API controller
	# to permit additional parameters to search on
	# @return [Hash]
	def query_params
		{}
	end

	# The resource class based on the controller
	# @return [Class]
	def resource_class
		begin
			@resource_class ||= resource_name.classify.constantize
		rescue NameError => e
			logger.error "NO RESOURCE FOR: #{ resource_name.classify }"
		end
	end

	# The collection class based on the controller
	# @return [Class]
	def collection_class
		@collection_class ||= resource_name.classify.constantize
	end

	# Returns the resource from the created instance variable
	# @return [Object]
	def get_resource
		return instance_variable_get("@#{resource_name}") if instance_variable_get("@#{resource_name}")
		set_resource
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_resource(resource = nil)
		return if !resource_class
		resource ||= resource_class.find(params[:id]) if params[:id] && params[:id].numeric?
		resource ||= resource_class.friendly.find(params[:id]) if params[:id] && !params[:id].numeric?
		resource ||= resource_class
		instance_variable_set("@#{resource_name}", resource)
		instance_variable_get("@#{resource_name}")
	end

	def allowed?
		return true
	end

	def verified_request?
		super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
	end

	def store_location
	  # store last url as long as it isn't a /users path
	  # session[:previous_url] = request.fullpath if request.format == 'html' && request.
		# store last url - this is needed for post-login redirect to whatever the user last visited.
		return unless request.get?

		if (request.format == 'html' &&
			request.path != Rails.application.routes.url_helpers.new_user_session_path &&
			request.path != Rails.application.routes.url_helpers.destroy_user_session_path &&
			request.path != Rails.application.routes.url_helpers.new_user_password_path &&
			request.path != Rails.application.routes.url_helpers.new_user_registration_path &&
			request.path != Rails.application.routes.url_helpers.user_registration_path &&
			request.path != Rails.application.routes.url_helpers.edit_user_password_path &&
			!request.xhr?) # don't store ajax calls
			session[:previous_url] = request.fullpath
		end
	end

	def after_sign_in_path_for(resource)
	  session[:previous_url] || root_path
	end
end
