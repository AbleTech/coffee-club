require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require_relative './support/authentication_helper'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  ENV["ADMIN_USERNAME"] = "test"
  ENV["ADMIN_PASSWORD"] = "password"
  ENV["SLACK_URL"] = "https://not.a.real.url/"
  # Add more helper methods to be used by all tests here...
end
