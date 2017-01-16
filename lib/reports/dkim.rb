require 'reports/base'

module Reports
  class Dkim < Base
    def create(email)
      report = super(email)

      headers = email.mail_message().header['DKIM-Signature'] || []
      unless headers.is_a?(Array)
        headers = [headers]
      end

      report.metric = Metric::Counter.new({:value => headers.size()})
      report.save!()
      report
    end
  end
end
