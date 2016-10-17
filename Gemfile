source 'https://rubygems.org'

gem 'activeadmin', github: 'activeadmin'
gem 'aws-sdk', '< 2.0'
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.1.0'
gem 'devise'
gem 'geocoder'
gem 'haml-rails'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'gibbon'
gem 'paperclip', '~> 4.2'
gem 'pg'
gem 'pundit'
gem 'rails', '4.2.1'
gem 'rollbar'
gem 'sass-rails', '~> 5.0'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'better_errors'
  gem 'engineyard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem "guard-minitest", require: false
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
end

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rubocop'
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'database_cleaner'
  gem "launchy"
  gem 'minitest-rails-capybara'
  gem "minitest-reporters"
  gem "mocha"
  gem 'selenium-webdriver'
  gem "test_after_commit"
end

group :production, :staging do
  gem 'unicorn'
  gem 'newrelic_rpm'
  gem 'ey_config'
  gem 'therubyracer', '~> 0.12.1',  platforms: :ruby # server side javascript runtime engine
end
