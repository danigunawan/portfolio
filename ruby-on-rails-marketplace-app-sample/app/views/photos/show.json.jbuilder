private_scope = false if local_assigns[:private_scope].nil?

json.partial! 'photos/photo', photo: @photo
