source 'https://rubygems.org'

ruby '2.3.1'

# JS runtime
gem 'therubyracer', platforms: :ruby

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
gem 'coffee-rails'

# style
gem "bulma-rails", "~> 0.2.3"
gem 'sass-rails', '>= 3.2'
gem 'font-awesome-rails'

# api
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# ORM/mongo
#gem 'mongoid', github: 'mongoid/mongoid'
gem 'mongoid', '~> 5.1.0'

# registry api
gem 'faraday'
gem 'faraday_middleware'
gem 'multi_json'
gem 'rugged', git: 'https://github.com/libgit2/rugged.git', submodules: true

# other
gem 'uuid'

# ours
gem 'xa-rules', git: 'https://github.com/Xalgorithms/xa-rules.git'

gem 'puma'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  # testing
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
  gem "rspec-rails"
  gem "mongoid-rspec"
end

group :development do
  gem 'pry-rails'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

group :production, :staging do
  gem 'foreman'
  gem 'rails_stdout_logging'
  gem 'rails_12factor'
end
