require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'adwords_api'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Market
  class Application < Rails::Application
    # config.middleware.use Rack::Deflater
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
		config.assets.paths << Rails.root.join("app", "assets", "fonts")
		config.assets.paths << Rails.root.join("app", "assets", "images")
		# img-02.jpg
		config.assets.enabled = true
		config.active_job.queue_adapter = :delayed_job

		config.generators do |g|
			g.orm :active_record
		end

		config.action_dispatch.default_headers = {
			'X-Frame-Options' => 'ALLOWALL'
		}
  end
end
