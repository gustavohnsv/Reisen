# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require "rails-controller-testing"

Rails::Controller::Testing.install

# Require support files
Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

# Check pending migrations
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Fixtures
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]

  # Devise helpers
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Warden::Test::Helpers

  # Transactions
  config.use_transactional_fixtures = true

  # Infer test types by file location
  config.infer_spec_type_from_file_location!

  # Filter Rails noise from backtraces
  config.filter_rails_from_backtrace!

  # Filter gems if needed
  # config.filter_gems_from_backtrace("gem name")
end
