require 'reports/base'

module Reports
  class Dkim < Base
    def create(email)
      headers = email.mail_message().headers['Dkim']
      
      report = email.reports.build({:key => 'dkim'})
      report.metric = Metric::Counter.new({:value => headers.size()})
      report
    end
  end
end