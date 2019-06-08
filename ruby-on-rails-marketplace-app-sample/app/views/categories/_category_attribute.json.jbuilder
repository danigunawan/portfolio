json.id category_attribute.id
json.name category_attribute.name
json.config category_attribute.config
json.published category_attribute.published
json.restricted category_attribute.restricted
json.required category_attribute.required
json.boolean category_attribute.boolean
json.priority category_attribute.priority
json.created_at category_attribute.created_at

json.min (category_attribute.category_attribute_values.minimum(:float_value) && category_attribute.category_attribute_values.minimum(:float_value) > 0 ? category_attribute.category_attribute_values.minimum(:float_value) : 0)
json.max category_attribute.category_attribute_values.maximum(:float_value)

json.category_attribute_values category_attribute.category_attribute_values.order(:priority).order(:value) do |category_attribute_value|
	json.extract! category_attribute_value, :id, :value, :float_value, :priority, :published, :boolean
	json.listings category_attribute_value.listings_count_cache
end
