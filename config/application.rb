require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BucketApp
  class Application < Rails::Application
    Rails.application.configure do
      config.autoload_paths << Rails.root.join('lib')
      require_relative '../spec/lib/muzzle/fake_clasp_repo'
      config.clasp_repo = FakeClaspRepo.new
    end
  end
end
