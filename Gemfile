source 'https://rubygems.org'

ruby '3.0.0'

gem 'activeadmin', '~> 2.9.0'
gem 'aws-sdk-s3', '~> 1.75', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'devise_token_auth'
gem 'fcm', '~> 1.0.2'
gem 'geokit-rails', '~> 2.3.2'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'sass-rails', '>= 6'
gem 'sendgrid-ruby', '~> 6.4.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'
gem 'yaaf', '~> 0.1.1'

group :development, :test do
  gem 'action-cable-testing', '~> 0.6.1'
  gem 'pry-byebug', '~> 3.9', platform: :mri
  gem 'pry-rails', '~> 0.3.9'
end

group :development do
  gem 'annotate'
  gem 'brakeman'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rootstrap'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'webdrivers'
end

group :test, :development do
  gem 'factory_bot_rails'
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 5.0.0'
end
