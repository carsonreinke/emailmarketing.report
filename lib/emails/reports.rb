require 'emails/base'
require 'reports/all'

module Emails
  class Reports < Base
    def initialize(email)
      @email = email
    end

    def create()
      return unless @email.site.verified

      Reports::Base::CLASSES.each do |klass|
        ReportJob.perform_later(klass.name, @email.id)
      end
    end
  end
end