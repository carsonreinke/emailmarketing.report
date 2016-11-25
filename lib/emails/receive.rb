require 'emails/base'
require 'emails/process_job'

module Emails
  #
  # 
  #
  class Receive < Base
    def initialize(message)
      @message = message
    end

    def create()
      Resque.enqueue(Emails::ProcessJob, @message)
    end
  end
end