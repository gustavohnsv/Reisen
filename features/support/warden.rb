# features/support/warden.rb

require 'warden/test/helpers'
World Warden::Test::Helpers

Before do
  Warden.test_mode!
end

After do
  Warden.test_reset!
end