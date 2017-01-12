require 'test_helper'
require 'emails/receive'

module Emails
  class ReceiveTest < ActiveSupport::TestCase
    include ActiveJob::TestHelper

    test "create" do
      Emails::Receive.new(
        Mail::Message.new().encoded()
      ).create()

      assert_queued ProcessJob
    end
  end
end
