require 'reports'

class ReportsJob < ApplicationJob
  queue_as :default

  def perform(email_id)
    @email = Email.find(email_id)

    return unless @email.site.verified

    Reports::Base::CLASSES.each do |klass|
      ReportJob.perform_later(klass.name, @email.id)
    end
  end
end
