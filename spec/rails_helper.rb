ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include Requests::JsonHelpers, type: :request
  config.include Requests::SlackPost, type: :request
  config.include Requests::SlackToken, type: :request

  config.before(:example) do
    Rails.configuration.clasp_repo.delete_all
  end
end
