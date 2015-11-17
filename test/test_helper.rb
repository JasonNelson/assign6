ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all

  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
end
