source "https://rubygems.org"

ruby "~> 3.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "~> 3.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 7.1"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 2.2"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 2.0"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.14"

# Gema para autenticação de usuário
gem "devise", "~> 4.9"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", "~> 1.2025", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.18", require: false

gem "rss", "~> 0.3"

gem "httparty", "~> 0.23"

gem "material_icons", "~> 4.0"

# Grupo para produção (Heroku)
group :production do
  gem "pg", "~> 1.6"
end

# Grupo para desenvolvimento (Local)
group :development, :test do
  gem "sqlite3", "~> 2.7"
end

group :development do
  gem "letter_opener", "~> 1.10"
end

gem "countries", "~> 8.0"
gem 'rails-i18n'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.11", platforms: %i[ mri windows ]

  gem "rspec-rails", "~> 8.0"
  gem "factory_bot_rails", "~> 6.5"
  gem "cucumber-rails", "~> 4.0", require: false
  gem "capybara", "~> 3.40"
  gem "database_cleaner-active_record", "~> 2.2"
  gem "rails-controller-testing", "~> 1.0"
  gem "simplecov", "~> 0.22", require: false
  gem "simplecov-lcov", "~> 0.9"
  gem "coveralls_reborn", "~> 0.29", require: false
  gem "selenium-webdriver", "~> 4.38"
  gem "reek", "~> 6.5", require: false
  gem "faker", "~> 3.5"
  gem "launchy", "~> 3.1"
  gem "webmock", "~> 3.26"
  gem "pry-rails", "~> 0.3"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "~> 4.2"
end

# O grupo de teste padrão foi movido para o grupo :development, :test
# group :test do
#   gem "capybara"
#   gem "selenium-webdriver"
# end
