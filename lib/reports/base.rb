require 'reports'

module Reports
  class Base
    CLASSES = []

    def self.inherited(klass)
      CLASSES << klass
    end

    def create(email) #Report[]
      email.reports.build({:key => self.class.name})
    end
  end
end
