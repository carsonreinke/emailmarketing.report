class Report < ApplicationRecord
  attr_accessor :email_id, :key

  belongs_to :emails
  belongs_to :metric, :polymorphic => true

  def content(options = {})
    options = options.merge({:metric => self.metric.value})
    I18n.translate(self.key, options)
  end
end