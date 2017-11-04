require 'reports'

module Reports
  class Base
    include EmailHelper


    CLASSES = []

    def self.inherited(klass)
      CLASSES << klass
    end

    def create(email); end
  end
end
