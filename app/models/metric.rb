class Metric < ActiveRecord::Base
  self.abstract_class = true

  has_one :report, :as => :metric
end