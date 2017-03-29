require 'test_helper'
require 'charts/dkim_usage'

module Charts
  class DkimUsageTest < ActiveSupport::TestCase
    def setup()
      @site = Site.create!({:name => 'Test', :url => 'http://example.com', :email_address => 'test@example.com', :verified => true})
    end

    test "create" do
      Charts::DkimUsage.new().create()
      chart = Chart.find_by({:key => 'Charts::DkimUsage'})
      assert_not_nil chart
      assert_equal [0, 0], chart.configuration.dig('data', 'datasets')[0]['data']
    end
  end
end
