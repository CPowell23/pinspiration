source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'masonry-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'rspec-rails'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem "omniauth-google-oauth2"
gem 'figaro'
gem 'faker'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'database_cleaner'
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
end

group :test do
  gem 'simplecov', :require => false
  gem 'capybara'
  gem "launchy"
  gem 'shoulda-matchers', '~> 3.1'
  gem 'rack_session_access'
  gem 'factory_girl'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
