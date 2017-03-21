require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SignalApp
  class Application < Rails::Application
    config.logger = Logger.new(STDOUT)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # 
    # React configs here
    config.browserify_rails.commandline_options = '-t reactify --extension=\”.react.js\”'
    config.browserify_rails.source_map_environments << 'development'
    config.to_prepare do
		  DeviseController.respond_to :html, :json
		end  
  end
end
