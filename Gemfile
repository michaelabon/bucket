source 'https://rubygems.org'

ruby '2.1.2'
gem 'rails', '4.1.5'
gem 'pg', '0.17.1'


gem 'rubocop', require: false

group :production do
  gem 'rails_12factor', '0.0.2'
end

group :development do
  gem 'heroku_san'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'brakeman', require: false
  gem 'colored', require: false
end

group :test do
  gem 'coveralls', require: false
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rake'
  gem 'rspec-expectations', '~> 3.1'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', require: false
end
