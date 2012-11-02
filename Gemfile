source 'http://rubygems.org'

gem 'rails', '3.2.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'torquebox-remote-deployer', '0.1.2.pre2'

gem 'jquery-rails'
gem 'json'
gem 'twitter', '2.0.2'

gem 'activerecord-jdbc-adapter', :require => false

platform :jruby do
  gem 'jruby-openssl' #, '~> 0.7.4.0'
  gem 'therubyrhino'
  gem 'get_back'
end

group :test do
  gem 'rspec-rails'
end

# START:db_driver
group :production do
  # START:pg
  gem 'jdbc-postgres'
  # END:pg
end

group :development, :test do
  # START:sqlite
  gem 'jdbc-sqlite3'
  # END:sqlite
end
# END:db_driver

gem "torquebox" #, "2.0.2"