require 'stats/base'

module Stats
  class Dkim < Base
    def report(email)
      headers = email.mail_message().headers['Dkim']
      #TODO
      #TODO Multiple
      Report.new({:site => self.site, :key => headers.empty?() ? 'stats.dkim.signed' : 'stats.dkim.unsigned'})
    end
  end
end