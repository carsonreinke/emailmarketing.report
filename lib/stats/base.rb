module Stats
  class Base
    attr_reader :site

    def initialize(site)
      @site = site
    end

    def report(email) #Report
      raise ArgumentError.new('Must be implemented')
    end
  end
end