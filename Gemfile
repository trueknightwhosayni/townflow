source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '= 3.6.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'letter_opener_web'
  gem 'letter_opener'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'binding_of_caller'
  gem 'rubocop', require: false
  gem 'awesome_print'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails'

  gem 'capybara-screenshot'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'fuubar'
  gem 'database_cleaner'
  gem 'launchy', require: false
  gem 'simplecov', require: false
  gem 'rspec-retry'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'pg'
gem 'rails_dt'
gem 'faker'
gem 'factory_bot_rails'
gem 'dotenv-rails', require: 'dotenv/rails-now'

gem "ni"
gem "neewom"
gem "peng"

gem "devise"
gem "rolify"
gem "cocoon"
gem "pundit"

gem "simple_form"
gem "hamlit"
gem "kaminari"

gem "sidekiq"
gem "email_validator"
gem "ancestry"
gem "simple_resource_controller"
