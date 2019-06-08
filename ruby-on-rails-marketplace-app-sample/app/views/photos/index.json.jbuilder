private_scope = false if local_assigns[:private_scope].nil?

json.partial! 'photos/photo', collection: @photos, as: :photo
