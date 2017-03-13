class Metric::Base < ApplicationRecord
  self.abstract_class = true

  #attr_accessor :value

  has_one :report, :as => :metric, :dependent => :destroy
end
