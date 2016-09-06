module Reports
  class Base
    attr_reader :site

    def initialize(site)
      @site = site
    end

    def create(email) #Metric::Base[]
      raise ArgumentError.new('Must be implemented')
    end
  end
end