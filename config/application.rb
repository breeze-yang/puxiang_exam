require_relative 'boot'

require 'rails/all'

require File.expand_path('../../lib/middlewares/api_request_credential', __FILE__)


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.default_locale = 'zh-CN'

    # set time zone to Beijing
    config.time_zone = 'Beijing'

    config.middleware.insert_before ActionDispatch::Cookies, DemoAPI::ApiRequestCredential

  end
end
