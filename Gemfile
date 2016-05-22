source 'https://rubygems.org'

ruby "2.2.4"

gem 'pg'

gem "recaptcha", require: "recaptcha/rails"

gem 'figaro' #for secret keys

gem 'exception_notification'

#for heroku
gem 'puma'

group :production, :staging do
    gem 'rails_12factor'
end

group :production do
  gem 'unicorn'
end

gem 'strip_attributes', '1.7.1'

gem 'devise'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'rails', '4.1.8'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
gem 'turbolinks', '~> 5.0.0.beta'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

group :development do
	gem 'spring'
	gem 'rack-mini-profiler'
	gem 'quiet_assets'
	gem 'tzinfo-data' #needed to run on windows
	gem "bullet"
	gem 'brakeman', :require => false #type brakeman in console to use
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

