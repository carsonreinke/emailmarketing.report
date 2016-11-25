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
      site.emails.create!({:message => message})
    rescue ActiveRecord::RecordNotFound
      raise $!
    rescue
      #Re-queue other errors
      self.class.message_queue.send(message)
      raise $!
    end
  end
end