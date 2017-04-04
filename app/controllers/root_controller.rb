class RootController < ApplicationController
  def index
    @charts = {
      'Charts::DkimUsage' => dkim_usage()
    }
  end


protected
  def dkim_usage()
    yes, no = nil
    ReportInteger.where({:key => 'Reports::DkimUsage'}).scoping do
      yes, no = ReportInteger.where(ReportInteger.arel_table[:integer].gt(0)).count(),
      ReportInteger.where(ReportInteger.arel_table[:integer].lt(1)).count()
    end

    {
        :type => 'pie',
        :data => {
            :labels => ['Yes', 'No'],
            :datasets => [{
                :label => translate('.label'),
                :data => [yes, no],
                :backgroundColor => [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)'
                ],
                :borderColor => [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)'
                ],
                :borderWidth => 1
            }]
        },
        :options => {
          :title => {
            :display => true,
            :text => translate('.text')
          }
        }
    }
  end
end
