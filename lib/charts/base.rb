module Charts
  class Base
    CLASSES = []

    def self.inherited(klass)
      CLASSES << klass
    end

    def create(); end
  end
end
