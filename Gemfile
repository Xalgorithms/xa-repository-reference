source 'https://rubygems.org'

ruby '2.3.0'

# JS runtime
# gem 'therubyracer', platforms: :ruby

# basics
gem 'rails', '4.2.4'
gem 'turbolinks'

# templates
gem 'slim-rails'

# js
gem 'jquery-rails'
gem 'stringjs-rails'
gem 'lodash-rails'
gem 'knockoutjs-rails'
gem 'js-routes'
gem 'uglifier', '>= 1.3.0'

# style
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails'

# api
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# ORM/rethinkdb
gem 'mongoid', github: 'mongoid/mongoid'

# registry api
gem 'faraday'
gem 'faraday_middleware'
gem 'multi_json'

# other
gem 'uuid'

# ours
gem 'xa-rules', git: 'https://github.com/Xalgorithms/xa-rules.git'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  # testing
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
  gem "rspec-rails"
end

group :development do
  gem 'pry-rails'
  gem 'spring'
  gem 'thin'
  gem 'web-console', '~> 2.0'
end

group :production, :staging do
  gem 'foreman'
  gem 'puma'
  gem 'rails_stdout_logging'
end
