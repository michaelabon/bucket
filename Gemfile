source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'httparty'
gem 'newrelic_rpm'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'colored', require: false
  gem 'pry-byebug', platform: :mri
  gem 'rubocop', require: false
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rake'
  gem 'rspec-expectations'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
