class Chart < ApplicationRecord
  store :configuration, {:coder => JSON}

  validates :key, {:presence => true, :uniqueness => {:case_sensitive => true}}
  validates :configuration, {:presence => true}
end
