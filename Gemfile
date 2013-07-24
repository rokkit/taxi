source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'



group :development do
  gem 'sqlite3'
end

group :production do
  gem 'therubyracer', platforms: :ruby
  gem 'mysql2'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'capybara', '2.0.3'  # capybara-webkit works with this version
  gem 'capybara-webkit'
  gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
  gem 'email_spec'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
#Authorization
gem 'devise'
gem 'cancan'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "twitter-bootstrap-rails"
gem 'backbone-on-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
