Geocoder.configure({
	timeout: 2,
  lookup: :google,
  key: 'xxxxxxxx',
  ip_lookup: :ipstack,
  cache: Redis.new,
  use_https: true
})

Geocoder.configure({ipstack:{api_key: ENV['IPSTACK_API_KEY'], use_https: false}})
