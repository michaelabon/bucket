require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_model/railtie'
require 'active_record/railtie'
# require "action_cable/engine"
# require "action_mailer/railtie"
# require "active_job/railtie"
# require "rails/test_unit/railtie"
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Top-level namespace for the Rails application.
module BucketApi
  # Rails application configuration and initialization.
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over
    # those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('bucket')

    if Rails.env.production?
      config.ignored_user_names = ENV['IGNORED_USER_NAMES'] || 'slackbot' # comma separated
      config.x.slack.subdomain = ENV.fetch('SLACK_SUBDOMAIN')
      config.x.slack.triggers_token = ENV.fetch('SLACK_TRIGGERS_TOKEN')
      config.x.slack.startup_token = ENV.fetch('SLACK_STARTUP_TOKEN')
    else
      config.ignored_user_names = ENV['IGNORED_USER_NAMES'] || 'slackbot,testbot'
      config.x.slack.subdomain = ENV['SLACK_SUBDOMAIN'] || 'bucket'
      config.x.slack.triggers_token = ENV['SLACK_TRIGGERS_TOKEN'] || 'SLACK_TRIGGERS_TOKEN_X'
      config.x.slack.startup_token = ENV['SLACK_STARTUP_TOKEN'] || 'SLACK_STARTUP_TOKEN_X'
    end
  end
end
