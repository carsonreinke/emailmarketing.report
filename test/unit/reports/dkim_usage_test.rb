require 'test_helper'
require 'reports/dkim'

module Reports
  class DkimUsageTest < ActiveSupport::TestCase
    def setup()
      @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
      @email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    end

    test "create" do
      Reports::DkimUsage.new().create(@email)

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::Dkim', report.key
    end

    test "create with dkim" do
      mail_message = @email.mail_message
      mail_message.header['DKIM-Signature'] = 'Test'
      @email.save!()

      Reports::DkimUsage.new().create(@email)

      @email.reload()
      report = @email.reports.take!()
      assert_equal 1, report.value
    end
  end
end
