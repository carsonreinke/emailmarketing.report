require 'reports/base'

module Reports
  class FromLocalAddress < Base
    def create(email)
      local = email.mail_message().header['From'].field.addrs.first().local rescue nil
      return if local.nil?()

      report = email.report_strings.find_or_initialize_by({:key => self.class.name})
      report.value = local
      report.save!()
    end
  end
end
