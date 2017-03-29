module Charts
  class Base
    CLASSES = []

    def self.inherited(klass)
      CLASSES << klass
    end

    def create(); end


  protected
    def model()
      Chart.find_or_initialize_by({:key => self.class.name})
    end
  end
end
