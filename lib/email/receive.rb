require 'email/base'

module Email
  #
  #
  #
  class Receive < Base
    def initialize(message)
      self.class.message_queue.send(message)
    end
  end
end