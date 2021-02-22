# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '~> 1.7', require: false
gem 'email_validator', '~> 2.2'
gem 'jb', '~> 0.8'
gem 'pry-rails', '~> 0.3'
gem 'puma', '~> 5.2'
gem 'rails', '~> 6.1', '>= 6.1.2.1'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'byebug', '~> 11.1', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.13'
  gem 'rubocop-rails', '~> 2.7.1', require: false
end

group :development do
  gem 'listen', '~> 3.4'
  gem 'spring', '~> 2.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
