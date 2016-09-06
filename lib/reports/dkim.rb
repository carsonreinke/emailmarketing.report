require 'reports/base'

module Reports
  class Dkim < Base
    def create(email)
      headers = email.mail_message().headers['Dkim']
      #TODO
      #TODO Multiple
      Metric::Counter.new({:site => self.site, :key => headers.empty?() ? 'stats.dkim.signed' : 'stats.dkim.unsigned'})
    end
  end
end