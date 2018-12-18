source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  ###doc [1] set up rspec and guard
  gem 'rspec-rails', '~> 3.5'
  # then run $ rails generate rspec:install
  gem 'webmock'

  gem 'guard-rspec', require: false
  # then run $ bundle exec guard init rspec
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
  gem 'capistrano-rvm'
end

group :test do
  ###doc [2] set up factory_girl
  # DEPRECATION gem 'factory_girl_rails'
  gem 'factory_bot_rails', '~> 4.0'

  ###doc [3] set up shoulda_matchers
  gem 'shoulda-matchers', '~> 3.1'

  ###doc [4] set up faker
  gem 'faker'

  ###doc [5] set up database_cleaner
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

###doc [6] set up figaro for env
# gem 'figaro'
# then run $ bundle exec figaro install
gem 'dotenv-rails', require: 'dotenv/rails-now'

###doc [7] set up API grape and swagger doc
gem 'grape'
gem 'grape-middleware-logger'
gem 'grape-entity'
gem 'hashie-forbidden_attributes'

# documentation
gem 'grape-swagger'
gem 'grape-swagger-rails'

# rename app
gem 'rename'

###doc [8] uncomment rack to handling Cross-Origin Resource Sharing (CORS) API
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

###doc [9] paginator
# Then choose your preferred paginator from the following:
gem 'kaminari'
# Finally...
gem 'api-pagination'

# oauth
gem 'doorkeeper'
gem 'wine_bouncer'

gem 'paranoia', '~> 2.2'
gem 'paper_trail'
gem 'seed_migration'

gem 'omniauth-identitas'
gem 'httparty'
gem 'ruby-identitas-api', '~> 0.6.0'

