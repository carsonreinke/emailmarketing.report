require 'test_helper'
require 'emails/receive'

module Emails
  class ReceiveTest < ActiveSupport::TestCase
    include ActiveJob::TestHelper

    test "create" do
      assert_enqueued_with({job: ProcessJob}) do
        Emails::Receive.new(
          Mail::Message.new().encoded()
        ).create()
      end
    end
  end
end
