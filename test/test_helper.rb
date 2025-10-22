ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests sequentially to simplify SQLite management in the API project.
    parallelize(workers: 1)

    # Add more helper methods to be used by all tests here...
  end
end
