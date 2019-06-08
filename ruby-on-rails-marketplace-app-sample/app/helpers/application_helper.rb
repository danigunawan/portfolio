module ApplicationHelper

	def title(alternate=nil)

		# return current_site.seo_for_request(request).title if current_site.seo_for_request(request) and current_site.seo_for_request(request).title
		return alternate if alternate
	end

	def description(alternate=nil)
		# current_site.seo_for_request(request).description && return if !current_site.seo_for_request(request).blank? and current_site.seo_for_request(request).description
		return alternate if alternate
	end

	def keywords(alternate=nil)
		# return current_site.seo_for_request(request).keywords if current_site.seo_for_request(request) and current_site.seo_for_request(request).keywords
		# return alternate if alternate
	end

	def location
		# return Geocoder.search('66.68.202.98').first if Rails.env.development?
		# request.location if request
	end
end
