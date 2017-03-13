ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

WebMock.enable!()
VCR.configure do |config|
  config.cassette_library_dir = File.join(Rails.root, 'test', 'vcr_cassettes')
  config.hook_into :webmock
end

class ActiveSupport::TestCase
  include ResqueUnit::Assertions

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup()
    Resque.reset!()
  end
end
