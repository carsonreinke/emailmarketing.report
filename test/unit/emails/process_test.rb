require 'test_helper'
require 'emails/process'

module Emails
  include ActiveJob::TestHelper

  class ProcessTest < ActiveSupport::TestCase
    test "create" do
      site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com'})
      message = Mail::Message.new()
      message.to = 'test@example.com'
      Emails::Process.new(
        message.encoded()
      ).create()

      site.reload()
      assert_equal site.emails.count, 1
    end
  end
end
