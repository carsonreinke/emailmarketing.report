class Report < ApplicationRecord
  attr_accessor :email_id, :key, :options

  belongs_to :emails
  belongs_to :metric, :polymorphic => true

  def content(options = {})
    options = options.merge(self.options)
    I18n.translate(self.key, options)
  end
end