source "https://rubygems.org"

ruby "~> 3.4"

# Core Rails
gem "rails", "~> 8.1"
gem "sprockets-rails", "~> 3.5"
gem "puma", "~> 7.1"
gem "importmap-rails", "~> 2.2"
gem "turbo-rails", "~> 2.0"
gem "stimulus-rails", "~> 1.3"
gem "jbuilder", "~> 2.14"

# Authentication & Utilities
gem "devise", "~> 4.9"
gem "tzinfo-data", platforms: [:windows, :jruby]
gem "bootsnap", "~> 1.18", require: false
gem "rss", "~> 0.3"
gem "httparty", "~> 0.23"
gem "material_icons", "~> 4.0"
gem "countries", "~> 8.0"
gem "rails-i18n"
gem "meta-tags"
gem "sitemap_generator"

# Production
group :production do
  gem "pg", "~> 1.6"
end

# Development + Test
group :development, :test do
  gem "sqlite3", "~> 2.2.0", force_ruby_platform: true
  gem "debug", "~> 1.11", platforms: %i[mri windows]
  gem "rspec-rails", "~> 8.0"
  gem "factory_bot_rails", "~> 6.5"
  gem "cucumber-rails", "~> 4.0", require: false
  gem "capybara", "~> 3.40"
  gem "selenium-webdriver", "~> 4.38"
  gem "database_cleaner-active_record", "~> 2.2"
  gem "rails-controller-testing", "~> 1.0"
  gem "simplecov", "~> 0.22", require: false
  gem "simplecov-lcov", "~> 0.9"
  gem "coveralls_reborn", "~> 0.29", require: false
  gem "reek", "~> 6.5", require: false
  gem "faker", "~> 3.5"
  gem "launchy", "~> 3.1"
  gem "webmock", "~> 3.26"
  gem "pry-rails", "~> 0.3"
  gem "axe-core-cucumber"
end

# Test only
group :test do
  gem "shoulda-matchers", "~> 6.0"
end

# Development only
group :development do
  gem "letter_opener", "~> 1.10"
  gem "web-console", "~> 4.2"
  gem "rack-mini-profiler"
end