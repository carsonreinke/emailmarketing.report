require 'charts/base'

module Charts
  class DkimUsage < Base
    def create()
      obj = self.model()

      yes, no = nil
      ReportInteger.where({:key => 'Reports::DkimUsage'}).scoping do
        yes, no =
          ReportInteger.where(ReportInteger.arel_table[:integer].gt(0)).count(),
          ReportInteger.where(ReportInteger.arel_table[:integer].lt(1)).count()
      end

      obj.configuration = {
          :type => 'pie',
          :data => {
              :labels => ['Yes', 'No'],
              :datasets => [{
                  :label => 'DKIM',
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
              :text => 'Signed with a DKIM signature?'
            }
          }
      }
      obj.save!()
    end
  end
end
