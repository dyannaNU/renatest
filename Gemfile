# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.0"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0", ">= 5.0.6"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

gem "whenever", "~> 0.9.X", require: false
gem "erubis", "~> 2.7"
gem "rails_admin", "~> 1.X"
gem "bootstrap", "~> 4.0.X"
gem "font-awesome-sass", "~> 4.7"
source "https://rails-assets.org" do
  gem "rails-assets-tether", ">= 1.3.3"
end

gem "inky-rb", "~> 1.X", require: "inky"
gem "premailer-rails", "~> 1.X"
gem "devise", github: "plataformatec/devise"
gem "devise-i18n", "~> 1.X"
gem "sentry-raven", "~> 2.X"
gem "paperclip", "~> 5.1"
gem "rubyzip", "~> 1.2", ">= 1.2.1"

# generate pdfs
gem "pdfkit", "~> 0.8.2"
gem "wkhtmltopdf-binary", "~> 0.12.3"

gem "factory_girl_rails", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara", "~> 2.13.0"
  gem "selenium-webdriver"
  gem "rubocop", "~> 0.46"
  gem "brakeman"
  gem "bundler-audit", require: false
  gem "rspec-rails", "~> 3.5.X"
  gem "rails-controller-testing", "~> 0.X"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "capistrano"
end

group :test do
  gem "poltergeist"
  gem "simplecov", require: false
  gem "timecop", "~> 0.8.1"
end
