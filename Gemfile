# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
gem 'bootsnap', require: false
gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'font-awesome-sass', '~> 6.5', '>= 6.5.1'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'pry-rails', '~> 0.3.9'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'rubocop', '~> 1.58'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'bootstrap'
  gem 'jquery-rails'
  gem 'letter_opener', '~> 1.8', '>= 1.8.1'
  gem 'sass-rails', '~> 6.0'
  gem 'web-console'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
