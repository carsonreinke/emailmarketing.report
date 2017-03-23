require 'test_helper'
require 'reports/size'

module Reports
  class SizeTest < ActiveSupport::TestCase
    def setup()
      @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
      @email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    end

    test "create" do
      Reports::Size.new().create(@email)

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::Size', report.key

      assert report.value > 0
    end
  end
end
