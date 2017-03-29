require 'test_helper'

class ChartTest < ActiveSupport::TestCase
  test "create" do
    Chart.create!({:key => 'MyTest', :configuration => {:something => :cool}})
  end
  # test "the truth" do
  #   assert true
  # end
end
