source 'https://rubygems.org'

ruby '3.1.2'

gem 'pg', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'rails', '>= 7.0.4.3', '< 8'
gem 'tzinfo-data'

# Protects against GHSA-vr8q-g5c7-m54m
# https://github.com/sparklemotion/nokogiri/security/advisories/GHSA-vr8q-g5c7-m54m
gem 'nokogiri', '>= 1.11.0.rc4'

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
  gem 'rubocop', '~> 1.50.1', require: false
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
