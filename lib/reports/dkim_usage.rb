require 'reports/base'

module Reports
  class DkimUsage < Base
    def create(email)
      report = email.report_integers.find_or_initialize_by({:key => self.class.name})

      headers = email.mail_message().header['DKIM-Signature'] || []
      unless headers.is_a?(Array)
        headers = [headers]
      end

      report.value = headers.size()
      report.save!()
      report
    end
  end
end
