source "https://rubygems.org"

ruby "~> 3.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1"

# The original asset pipeline for Rails
gem "sprockets-rails", "~> 3.5"

# Use the Puma web server
gem "puma", "~> 7.1"

# Use JavaScript with ESM import maps
gem "importmap-rails", "~> 2.2"

# Hotwire's SPA-like page accelerator
gem "turbo-rails", "~> 2.0"

# Hotwire stimulus framework
gem "stimulus-rails", "~> 1.3"

# Build JSON APIs with ease
gem "jbuilder", "~> 2.14"

# Authentication
gem "devise", "~> 4.9"

# Timezone support for Windows
gem "tzinfo-data", platforms: [:windows, :jruby]

# Reduces boot times through caching
gem "bootsnap", "~> 1.18", require: false

gem "rss", "~> 0.3"
gem "httparty", "~> 0.23"
gem "material_icons", "~> 4.0"
gem "countries", "~> 8.0"
gem "rails-i18n"

# Production database adapter
group :production do
  gem "pg", "~> 1.6"
end

# Development + Test database adapter
group :development, :test do
  gem "sqlite3", "~> 2.2.0", force_ruby_platform: true
  
  # Debugging
  gem "debug", "~> 1.11", platforms: %i[mri windows]

  # Testing frameworks
  gem "rspec-rails", "~> 8.0"
  gem "factory_bot_rails", "~> 6.5"
  gem "cucumber-rails", "~> 4.0", require: false
  gem "capybara", "~> 3.40"
  gem "selenium-webdriver", "~> 4.38"

  # DB cleaning for tests
  gem "database_cleaner-active_record", "~> 2.2"

  # Controller testing helpers
  gem "rails-controller-testing", "~> 1.0"

  # Code coverage
  gem "simplecov", "~> 0.22", require: false
  gem "simplecov-lcov", "~> 0.9"
  gem "coveralls_reborn", "~> 0.29", require: false

  # Code smell detection
  gem "reek", "~> 6.5", require: false

  # Test data generation
  gem "faker", "~> 3.5"
  
  # Helpers
  gem "launchy", "~> 3.1"
  gem "webmock", "~> 3.26"
  gem "pry-rails", "~> 0.3"
end

# Test-only gems
group :test do
  gem "shoulda-matchers", "~> 6.0"
end

# Development-only gems
group :development do
  gem "letter_opener", "~> 1.10"
  
  # Console on exceptions pages
  gem "web-console", "~> 4.2"
end