require 'test_helper'
require 'reports/html_downloaded_size'

module Reports
  class HtmlDownloadedSizeTest < ActiveSupport::TestCase
    def setup()
      @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
      @email = @site.emails.create!({:message => Mail::Message.new().encoded()})
    end

    test "create" do
      @email.mail_message = Mail::new do
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<h1><img src="https://avatars2.githubusercontent.com/u/378481?v=3&s=460" ></h1>'
        end
      end

      VCR.use_cassette('reports_html_downloaded_size_create') do
        Reports::HtmlDownloadedSize.new().create(@email)
      end

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::HtmlDownloadedSize', report.key

      assert_equal 28381, report.value
    end

    test "missing asset" do
      @email.mail_message = Mail::new do
        html_part do
          content_type 'text/html; charset=UTF-8'
          body '<h1><img src="https://avatars2.githubusercontent.com/u/" ></h1>'
        end
      end

      VCR.use_cassette('reports_html_downloaded_size_missing_asset') do
        Reports::HtmlDownloadedSize.new().create(@email)
      end

      @email.reload()
      report = @email.reports.take!()
      assert_equal 'Reports::HtmlDownloadedSize', report.key

      assert_equal 63, report.value
    end

    test "missing part" do
      Reports::HtmlDownloadedSize.new().create(@email)

      @email.reload()
      assert_nil @email.reports.take()
    end
  end
end
