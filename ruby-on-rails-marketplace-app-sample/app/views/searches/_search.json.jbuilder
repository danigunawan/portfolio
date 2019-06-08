json.id search.id
json.count search.listings(params[:page]).total
json.location search.location
json.page search.listings(params[:page]).results.current_page
json.pages search.listings(params[:page]).results.total_pages
json.latitude search.latitude
json.longitude search.longitude
json.title search.title
json.keywords search.keywords
json.category do
	json.id search.category ? search.category.id : nil
	json.name search.category ? search.category.name : nil
	json.ref search.category ? category_url(search.category) : categories_url
end

if params[:matrix]
	json.cache! [search], expires: 12.hours do
		json.matrix search.matrix.results.each do |listing|
			json.id listing.id
			json.url listing.is_a?(Business) ? '' : listing_url(listing)
			json.title listing.title.titleize
			json.latitude listing.latitude
			json.longitude listing.longitude
		end
	end
end

json.results search.listings(params[:page]).results do |result|
	if result.is_a? Business
		json.type 'business'
		json.partial! 'searches/business', business: result
	elsif result.is_a? Listing
		json.type 'listing'
		json.partial! 'searches/listing', listing: result
	end
end
