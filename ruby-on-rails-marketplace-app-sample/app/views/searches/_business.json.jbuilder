json.id business.id
json.name business.name
json.safe_address business.safe_address
json.latitude business.latitude
json.longitude business.longitude
json.contact_name business.contact_name.titleize if business.contact_name

if location && location.latitude && business.distance_from([location.latitude,location.longitude])
  json.distance_from business.distance_from([location.latitude,location.longitude]).ceil
end

json.tags business.business_tags.each do |tag|
  json.name tag.name
  json.url business_tag_path(tag)
end
