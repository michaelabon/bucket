source 'https://rubygems.org'

ruby '2.2.2'
gem 'rails', '4.1.6'
gem 'pg', '0.17.1'

gem 'httparty', '~> 0.13.1'

group :production do
  gem 'rails_12factor', '0.0.2'
end

group :development do
  gem 'heroku_san'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'colored', require: false
  gem 'pry-byebug'
  gem 'rubocop', '~> 0.26.1', require: false
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rake'
  gem 'rspec-expectations', '~> 3.1'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', require: false
end
