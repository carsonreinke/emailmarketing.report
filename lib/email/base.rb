require 'sysvmq'

module Email
  class Base
    class << self
      def message_queue()
        @message_queue ||= SysVMQ.new(0xDEADC0DE, 1024, SysVMQ::IPC_CREAT | 0666)
      end
    end
  end
end