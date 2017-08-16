require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleUsingZaimApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    I18n.available_locales = [:en, :ja]
    I18n.config.enforce_available_locales = true
    config.i18n.default_locale = :en

    config.enable_dependency_loading = true
    config.autoload_paths += Dir["#{config.root}/lib"]
    config.autoload_paths << "#{config.root}/app/services"


    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework false
      g.factory_girl false
    end
  end
end
