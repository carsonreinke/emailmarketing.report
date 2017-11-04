require 'test_helper'
require 'reports/conditional_comments'

module Reports
  class ConditionalCommentsTest < ActiveSupport::TestCase
    def setup()
      @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
      @email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    end

    test "create" do
      @email.mail_message = Mail::new do
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<!--[if mso]>Test<![endif]-->'
        end
      end

      Reports::ConditionalComments.new().create(@email)

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::ConditionalComments', report.key

      assert_equal 'mso', report.value
    end

    test "most common" do
      @email.mail_message = Mail::new do
        html_part do
          content_type 'text/html; charset=UTF-8'
          body <<-HTML
            <!--[if mso 9]>Test<![endif]-->
            <!--[if mso 8]>Test<![endif]-->
            <!--[if mso 9]>Test<![endif]-->
          HTML
        end
      end

      Reports::ConditionalComments.new().create(@email)

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::ConditionalComments', report.key

      assert_equal 'mso 9', report.value
    end

    test "parse error" do
      @email.mail_message = Mail::new do
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<!--[if mso]>Test'
        end
      end

      Reports::ConditionalComments.new().create(@email)

      @email.reload()
      assert_nil @email.reports.take()
    end
  end
end
