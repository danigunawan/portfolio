json.id saved_search.id
json.state_path saved_search.state_path
json.created_at saved_search.created_at

json.search do
	json.partial! partial: 'searches/search', locals: {search: saved_search.search} if saved_search.search
end
