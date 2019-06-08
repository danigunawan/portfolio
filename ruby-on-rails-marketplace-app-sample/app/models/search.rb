class Search < ActiveRecord::Base
	acts_as_paranoid

	#===============================================================

	belongs_to :site
  belongs_to :category

	has_many :saved_searches

	has_many :followers,
		through: :saved_searches,
		class_name: 'User'

	geocoded_by :location # can also be an IP address
	after_validation :geocode # auto-fetch coordinates

	# ---------------------------------------------
	# Meta helpers:
	# ---------------------------------------------

	def title
		@title = []

		if keywords
			@title << keywords
		end

		if category
			@title << category.name.pluralize
		else
			# @title << "Everything" if keywords.blank?
		end

		@title << "For Sale"

		@title << location if location

		unique_words = {}
		# Remove duplicate words in the title.
		@title
			.select{ |item| !unique_words.has_key?(item) | !(unique_words[item] = true) }
			.join(' ').squish.titleize
	end

	def state_path
		@state_path = "/search"
		@state_path = @state_path.add_param_to_uri('location', location) if location
		@state_path = @state_path.add_param_to_uri('keywords', keywords) if keywords
		@state_path = @state_path.add_param_to_uri('category_id', category_id) if category_id
		@state_path
	end

	# ---------------------------------------------
	# Class helpers:
	# ---------------------------------------------

	def self.normalize_params(params, instance=nil)
		params[:site_id] = nil if params[:site_id].blank?
		params[:category_id] = nil if params[:category_id].blank?
		params[:location] = nil if params[:location].blank?
		params[:keywords] = "" if params[:keywords].blank?

		{
			site_id: params[:site_id] || (!instance.blank? ? instance.site_id : nil),
			category_id: params[:category_id] || (!instance.blank? ? instance.category_id : nil),
			location: params[:location] || (!instance.blank? ? instance.location : nil),
			distance: params[:distance] || (!instance.blank? ? instance.distance : nil),
			keywords: params[:keywords] || (!instance.blank? ? instance.keywords : nil)
		}
	end

	def normalize_params(params={})
		Search.normalize_params(params, self)
	end

	# ---------------------------------------------
	# Query Results:
	# ---------------------------------------------

	def query_params
		normalize_params.select { |k,v| v && !k.in?([:keywords, :location, :distance, :latitude, :longitude])}
	end

	# Builds the query filter portion of the where clause. i.e. Adds any ranges of values of min or max.
	def query_filters
		@query_filter = nil
		filter_string = ""
		filter_params = {}

		if self.price_min
			filter_string = "price >= :price_min"
			filter_params[:price_min] = self.price_min
		end

		if self.price_max
			filter_string += "#{ self.price_min ? " AND " : "" }price <= :price_max"
			filter_params[:price_max] = self.price_max
		end

		if filter_string.length > 0
			@query_filter = [filter_string,filter_params]
		end

		@query_filter
	end

	# Keyword wrapper for solr naming collision.
	def query_string
		keywords
	end

	def bounds= value
		@bounds = value.split(',').map(&:to_f)
	end

	def bounds
		@bounds
	end

	def expanded_bounds(magnitude=1.0)
		[
			((bounds[0]*magnitude).floor - 1)/magnitude,
			((bounds[1]*magnitude).floor - 1)/magnitude,
			((bounds[2]*magnitude).ceil + 1)/magnitude,
			((bounds[3]*magnitude).ceil + 1)/magnitude
		]
	end

	def matrix(page=1, page_size=500)
		self.listings(page,page_size)
	end

	def listings(page=1, page_size=10)
		page ||= 1
		page = 1 if page.to_i < 1

		search_response = Sunspot.search [Listing,Business] do
			fulltext query_string, :fields => [:title, :description, :title_dynamic, :safe_address, :category_name, :contact_name]

			# with :site_id, site.id
			with :category_syndicate_id, category.category_syndicate.id if category
			with :category_syndicate_id, site.categories.map{ |i| i.category_syndicate.id } if !category

			with :latitude, expanded_bounds[0]..expanded_bounds[2] if !bounds.blank?
			# without :latitude, expanded_bounds[0]..expanded_bounds[2] if bounds
			with :longitude, expanded_bounds[1]..expanded_bounds[3] if !bounds.blank?
			# without :longitude, expanded_bounds[1]..expanded_bounds[3] if bounds

			order_by :edited_at, :desc

			paginate :page => page, :per_page => page_size
		end

		search_response
	end
end
