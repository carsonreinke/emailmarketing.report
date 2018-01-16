require 'emails/base'

module Emails
  #
  #
  #
  class Process < Base
    def initialize(message)
      @message = message
    end

    def create()
      mail_message = Mail::Message.new(@message)
      local_address = mail_message.header['To'].field.addrs.first().local

      #Only use the local address to match the site
      site = Site.find_by!(Site.arel_table[:email_address].matches("#{local_address}@%"))
      site.emails.create!({:message => @message})
    end
  end
end
