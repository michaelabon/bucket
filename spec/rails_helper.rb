ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'shoulda/matchers'
if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_paths = ["#{Rails.root}/spec/fixtures"]
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include Requests::JsonHelpers, type: :request
  config.include Requests::SlackPost, type: :request
  config.include Requests::SlackToken, type: :request
end
