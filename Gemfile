source 'https://rubygems.org'

ruby '2.2.3'
gem 'rails'
gem 'pg'

gem 'httparty'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'heroku_san'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'colored', require: false
  gem 'did_you_mean'
  gem 'pry-byebug'
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
