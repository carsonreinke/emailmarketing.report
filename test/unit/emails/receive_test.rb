require 'test_helper'
require 'emails/receive'

module Emails
  include ActiveJob::TestHelper
  
  class ReceiveTest < ActiveSupport::TestCase
    test "create" do
      Emails::Receive.new(
        Mail::Message.new().encoded()
      ).create()
      
      assert_enqueued_jobs 1
    end
  end
end