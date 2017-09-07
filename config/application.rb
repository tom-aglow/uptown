require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Uptown
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Solve the issue with precompiling ES6 on prod env
    config.assets.initialize_on_precompile = false

    # Default host for mailers
    config.action_mailer.default_url_options = {
        host: 'https://uptown-barbers.herokuapp.com/'
    }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
