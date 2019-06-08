json.id @category.id
json.name @category.name
json.ref category_url(@category)
json.assignable @category.assignable?
json.locked @category.locked?
json.promoted @category.promoted

if @category.category
	json.category do
	  json.id @category.category ? @category.category.id : nil
	  json.name @category.category ? @category.category.name : nil
	  json.ref @category.category ? category_url(@category.category) : categories_url
	end
end

json.categories @category.categories do |category|
	json.id category.id
	json.name category.name
	json.assignable category.assignable?
	json.ref category_url(category)
end

json.category_attributes @category.category_attributes do |category_attribute|
	json.id category_attribute.id
end
