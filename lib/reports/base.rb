require 'reports'

module Reports
  class Base
    CLASSES = []

    def self.inherited(klass)
      CLASSES << klass
    end

    def create(email); end
  end
end
