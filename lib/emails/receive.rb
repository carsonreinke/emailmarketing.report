require 'emails/base'

module Emails
  #
  #
  #
  class Receive < Base
    def initialize(message)
      @message = message
    end

    def create()
      #Don't use #perform_later instead use Resque#enqueue so entire Rails environment does not have to be loaded
      Resque.enqueue(ProcessJob, @message)
    end
  end
end
