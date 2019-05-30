source 'https://rubygems.org'

ruby '2.6.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 3.12'
gem 'rails'

gem 'httparty'
gem 'newrelic_rpm'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'colored', require: false
  gem 'pry-byebug', platform: :mri
  gem 'rake'
  gem 'rubocop', '~> 0.70.0', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-expectations'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
