require 'sysvmq'
require 'email'

module Email
  class Base
    class << self
      def message_queue()
        @message_queue ||= SysVMQ.new(0xEEEEEEEE, 1024, SysVMQ::IPC_CREAT | 0666)
      end
    end
  end
end