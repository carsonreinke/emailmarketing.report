class Report < ApplicationRecord
  attr_accessor :email_id, :metric_id, :metric_type, :key

  belongs_to :email
  belongs_to :metric, :polymorphic => true

  validates :email, {:presence => true}
  validates :metric, {:presence => true}

  def content(options = {})
    options = options.merge({:metric => self.metric.value})
    I18n.translate(self.key, options)
  end
end