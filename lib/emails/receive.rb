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
      ProcessJob.perform_later(@message)
      ##Don't use #perform_later instead use Resque#enqueue so entire Rails environment does not have to be loaded
      #Resque.enqueue(ProcessJob, @message)
      #Resque.enqueue(
      #  ActiveJob::QueueAdapters::ResqueAdapter::JobWrapper,
      #  {
      #    "job_class"=>"ProcessJob",
      #    "job_id"=>SecureRandom.uuid,
      #    "queue_name"=>"default",
      #    "priority"=>nil, "arguments"=>[@message],
      #    "locale"=>"en"
      #  }
      #)
    end
  end
end
