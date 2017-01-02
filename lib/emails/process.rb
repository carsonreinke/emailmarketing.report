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

      site = Site.find_by!({:email_address => mail_message.to})
      site.emails.create!({:message => @message})
    end
  end
end
