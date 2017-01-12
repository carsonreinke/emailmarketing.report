require 'emails/process'

class ProcessJob < ApplicationJob
  @queue = :default
  queue_as @queue

  def perform(message)
    @email = Emails::Process.new(message).create()

    ReportsJob.perform_later(@email.id)
  end
end
