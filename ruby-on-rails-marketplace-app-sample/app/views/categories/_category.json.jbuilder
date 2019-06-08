json.id category.id
json.name category.name
json.published category.published
json.assignable category.assignable?
json.locked category.locked?
json.promoted category.promoted

json.ref category_url(category)

if category.category
	json.category do
	  json.id category.category ? category.category.id : nil
	  json.name category.category ? category.category.name : nil
	  json.ref category.category ? category_url(category.category) : categories_url
	end
end

json.categories category.categories, partial: 'category', as: :category
json.category_attributes category.category_attributes.order(priority: :asc), partial: 'category_attribute', as: :category_attribute

json.price_unit_attribute do
	json.partial! partial: 'category_attribute', locals: {category_attribute: category.price_unit_attribute} if category.price_unit_attribute
end
