source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'pg', '~> 1.6'
gem 'puma', '~> 7.1'
gem 'rails', '>= 7.0.4.3', '< 9'
gem 'tzinfo-data'

gem 'nokogiri', '~> 1.19'

gem 'httparty'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'listen'
  gem 'solargraph'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.1.0'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'colored', require: false
  gem 'pry-byebug', platform: :mri
  gem 'rake'
  gem 'rubocop', '~> 1.82.1', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
end

group :test do
  gem 'coveralls_reborn', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec'
  gem 'rspec-expectations'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
