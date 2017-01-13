require 'emails/process'

class ProcessJob < ApplicationJob
  queue_as :default

  def perform(message)
    @email = Emails::Process.new(message).create()

    ReportsJob.perform_later(@email.id)
  end
end
