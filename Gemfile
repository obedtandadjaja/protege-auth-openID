source 'http://rubygems.org'

gem 'rails', '~>3.2'
gem 'jquery-rails'
gem 'squeel'
gem 'constant_cache'
gem 'html5_validators'
gem 'validate_url'
gem 'validate_email'
gem 'fb_graph'
gem 'rack-oauth2'
gem 'openid_connect'
gem 'rename'
gem 'test-unit', '~> 3.0'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'turn', :require => false
end

group :production do
  gem 'pg'
  gem 'rack-ssl', :require => 'rack/ssl'
end