require 'reports'

module Reports
  class Base
    CLASSES = []

    def self.inherited(klass)
      CLASSES << klass
    end
    
    attr_reader :site

    def initialize(site)
      @site = site
    end

    def create(email) #Report[]
      raise ArgumentError.new('Must be implemented')
    end
  end
end