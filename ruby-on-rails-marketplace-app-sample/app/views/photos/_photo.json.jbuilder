private_scope = false if local_assigns[:private_scope].nil?

json.id photo.id

json.created_at photo.created_at
json.updated_at photo.updated_at

json.title photo.title
json.description photo.description

json.key photo.key

json.processed photo.processed
json.uploaded photo.uploaded

json.original photo.original
json.large photo.large
json.medium photo.medium
json.small photo.small
json.square photo.square
json.poster photo.poster

json.url photo.url

json.user photo.user.id if photo.user

json.ref photo_path(photo)

json.buckets do
  json.original photo.bucket(:original).fields
end
