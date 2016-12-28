class Metric::Base < ApplicationRecord
  self.abstract_class = true
  
  attr_accessor :value
end
