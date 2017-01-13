require 'reports/all'

class ReportJob < ApplicationJob
  queue_as :default

  def perform(class_name, email_id)
    @klass = class_name.constantize()
    @email = Email.find(email_id)
    @klass.new().create(@email)
  end
end
