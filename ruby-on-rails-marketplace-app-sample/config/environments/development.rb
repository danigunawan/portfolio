require 'active_support/core_ext/numeric/bytes'

Market::Application.configure do
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

	config.cache_classes = false # controls whether or not application classes and modules should be reloaded on each request
	config.action_view.cache_template_loading = false # controls whether or not templates should be reloaded on each request

  # Set the cache store to memory for settings and other cache items.
  # config.cache_store = :memory_store, { size: 0.megabytes }
  config.cache_store = :redis_store, 'redis://localhost:6379/0/market/cache'

  config.action_controller.action_on_unpermitted_parameters = :log
	config.log_level = :debug

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Do not eager load code on boot.
  config.eager_load = true

  # config.assets.js_compressor = Uglifier.new(mangle: false)
  # config.assets.css_compressor = :sass

  # Live reload middleware insertion.
  config.middleware.insert_after ActionDispatch::Static, Rack::LiveReload

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
	config.action_mailer.delivery_method = :site_deliverer

	# config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false
  config.serve_static_files = true
	config.assets.enabled = true
	config.assets.digest = false

  # config.action_controller.asset_host = ENV['ASSET_HOST']
end
