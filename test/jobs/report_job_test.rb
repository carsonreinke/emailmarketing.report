require 'test_helper'
require 'reports'

class ReportJobTest < ActiveJob::TestCase
  def setup()
    @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
    @email = @site.emails.create!({:message => Mail::Message.new().encoded()})
  end

  test "perform" do
    ReportJob.perform_now(Reports::DkimUsage.name, @email.id)
  end
end
