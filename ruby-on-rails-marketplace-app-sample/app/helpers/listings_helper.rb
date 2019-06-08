module ListingsHelper

	def query_path(query=nil)
		if query and query.slug
			query.slug
		else
			"/listings"
		end
	end

	def query_url(query=nil)
		request.protocol + request.host + query_path(query)
	end

	def recommended_listings(count=10,listing=nil,site=nil)
		return [] if !site

		# listings = site.listings.where(category_id: listing.category.id) if listing && listing.category
		listings ||= site.listings

		results = listings.order(updated_at: :desc).limit(100).shuffle[0..count-1]

		return (results + results + results + results + results).slice(0,count)
	end

	def recommended_listings_from_seller(count=10,seller=nil,site=nil)
		if seller and count > 0
			seller.listings.order(updated_at: :desc).limit(100).shuffle[0..count-1]
		end
	end

	def recommended_sellers
	end
end
