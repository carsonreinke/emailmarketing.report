module Emails
  #
  # Lightweight Resque job
  #
  class ReceiveJob
    @queue = :default

    def self.perform(message)
      ProcessJob.perform_later(message)
    end
  end
end
