source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'pg'
gem 'mysql2'

gem 'nokogiri'

gem 'composite_primary_keys'

# queueing
gem "resque", "~> 2.0.0.pre.1", github: "resque/resque"

# user management 
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

gem 'rack-timeout'

gem 'haml', "~> 3.1"
#gem 'sass'
gem 'coffee-script'
gem 'capybara'
#gem 'capybara-webkit', '~> 1.1.1'
gem 'poltergeist'
gem 'headless'
# twitter bootstrap support
# https://github.com/seyhunak/twitter-bootstrap-rails

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'libv8'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'

  gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem 'twitter-bootstrap-rails'
  # twitter bootstrap css & javascript toolkit
  gem 'twitter-bootswatch-rails', '~> 2.3.2'
  gem 'twitter-bootswatch-rails-fontawesome'

  #gem 'asset_sync'

end

# twitter bootstrap helpers gem, e.g., alerts etc...
gem 'twitter-bootswatch-rails-helpers'
gem 'jquery-rails'
gem 'gravtastic'

group :development do
  gem 'erb2haml'
  gem 'awesome_print'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'autotest'
  #gem 'ZenTest'
  #gem 'autotest-growl'
  gem 'autotest-fsevent'
  gem 'simplecov', "~> 0.8.2"
  gem 'simplecov-rcov'
  gem 'spork-rails'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
