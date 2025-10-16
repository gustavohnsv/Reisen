source "https://rubygems.org"

ruby "~> 3.3.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 7.0.3"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Gema para autenticação de usuário
gem "devise"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem "rss"

gem "httparty"

# Grupo para produção (Heroku)
group :production do
  gem "pg", "~> 1.1"
end

# Grupo para desenvolvimento (Local)
group :development, :test do
  gem "sqlite3", "~> 1.4"
end


group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # GEMS ADICIONADAS PARA O PROJETO DE ENGENHARIA DE SOFTWARE
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "cucumber-rails", require: false
  gem "capybara"
  gem "database_cleaner-active_record"
  gem 'rails-controller-testing'
  gem "simplecov", require: false
  gem "simplecov-lcov"
  gem "coveralls_reborn", "~> 0.28", require: false
  gem "selenium-webdriver", "~> 4.8"
  gem "reek", require: false
  gem "faker"
  gem "launchy"
  gem "webmock"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

# O grupo de teste padrão foi movido para o grupo :development, :test
# group :test do
#   gem "capybara"
#   gem "selenium-webdriver"
# end
