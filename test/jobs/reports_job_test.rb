require 'test_helper'

class ReportsJobTest < ActiveJob::TestCase
  def setup()
    @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
  end

  test "perform" do
    email = @site.emails.create!({:message => Mail::Message.new().encoded()})

    ReportsJob.perform_now(email.id)

    assert_enqueued_jobs Reports::Base::CLASSES.size(), {:only => ReportJob}
  end

  test "perform unverified" do
    @site.verified = false
    @site.save!()
    email = @site.emails.create!({:message => Mail::Message.new().encoded()})

    ReportsJob.perform_now(email.id)

    assert_enqueued_jobs 0
  end
end
