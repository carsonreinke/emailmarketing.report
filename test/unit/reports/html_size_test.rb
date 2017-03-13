require 'test_helper'
require 'reports/html_size'

module Reports
  class HtmlSizeTest < ActiveSupport::TestCase
    def setup()
      @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
      @email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    end

    test "create" do
      @email.mail_message = Mail::new do
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<h1>This is HTML</h1>'
        end
      end

      Reports::HtmlSize.new().create(@email)

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::HtmlSize', report.key

      assert_equal 21, report.metric.value
    end

    test "missing" do
      Reports::HtmlSize.new().create(@email)

      @email.reload()
      assert_nil @email.reports.take()
    end
  end
end
