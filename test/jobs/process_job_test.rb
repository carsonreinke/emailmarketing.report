require 'test_helper'

class ProcessJobTest < ActiveJob::TestCase
  test "perform" do
    site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com'})
    message = Mail::Message.new()
    message.to = 'test@example.com'

    assert_enqueued_with({job: ReportsJob}) do
      ProcessJob.perform_now(message.encoded())
    end

    site.reload()
    assert_equal site.emails.count, 1
  end

  test "perform missing site" do
    message = Mail::Message.new()
    message.to = 'test@example.com'

    assert_raises(ActiveRecord::RecordNotFound) do
      ProcessJob.perform_now(message.encoded())
    end
  end
end
