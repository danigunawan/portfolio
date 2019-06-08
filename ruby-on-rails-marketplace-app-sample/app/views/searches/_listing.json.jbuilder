json.id listing.id
json.url listing_url(listing)
json.title listing.title.titleize
json.title_dynamic listing.title_dynamic.titleize
json.safe_address listing.safe_address
json.latitude listing.latitude
json.longitude listing.longitude
json.featured listing.is_featured?
json.contact_name listing.contact_name

json.photos listing.photos do |photo|
  json.url photo.url
end

json.description truncate(listing.description_clean(current_user), length:100).html_safe
json.placeholder_photo_url image_url(listing.placeholder_photo_path)

if listing.category
  json.category do
    json.id listing.category ? listing.category.id : nil
    json.name listing.category ? listing.category.name : nil
    json.ref listing.category ? category_url(listing.category) : categories_url
  end
end

json.price listing.price

if listing.price_unit_formatted
  json.price_unit listing.price_unit_formatted
end
