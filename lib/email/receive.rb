require 'email/base'

module Email
  #
  #
  #
  class Receive < Base
    def initialize(message)
      @message = message
    end

    def create()
      self.class.message_queue.send(@message)
    end
  end
end