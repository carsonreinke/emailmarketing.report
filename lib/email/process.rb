require 'email/base'

module Email
  #
  #
  #
  class Process < Base
    def initialize()
      message = self.class.message_queue.receive()
      mail_message = Mail::Message.new(message)

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