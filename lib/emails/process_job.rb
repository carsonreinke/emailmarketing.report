require 'emails/base'
require 'emails/process'
require 'emails/reports'

module Emails
  #
  # Lightweight Resque job
  #
  class ProcessJob < Base
    def self.queue()
      :default
    end

    def self.perform(message)
      Emails::Reports.new(
        Emails::Process.new(message).create()
      ).create()
    end
  end
end