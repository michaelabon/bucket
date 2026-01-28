ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails' do
    enable_coverage :branch
    primary_coverage :branch
    minimum_coverage line: ENV.fetch('COVERAGE_MINIMUM', 98.5).to_f,
                     branch: ENV.fetch('COVERAGE_MINIMUM', 98.5).to_f
    add_filter '/spec/'
  end
end

require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'shoulda/matchers'

Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_paths = [Rails.root.join('spec/fixtures').to_s]
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include Requests::JsonHelpers, type: :request
  config.include Requests::SlackPost, type: :request
  config.include Requests::SlackToken, type: :request
end
