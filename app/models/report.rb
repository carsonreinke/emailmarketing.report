class Report < ApplicationRecord
  #attr_accessor :email_id, :metric_id, :metric_type, :key

  belongs_to :email, :dependent => :destroy
  belongs_to :metric, :polymorphic => true, :dependent => :destroy

  validates :email, {:presence => true}
  validates :metric, {:presence => true}
  validates :key, {:presence => true, :uniqueness => {:scope => :email_id, :case_sensitive => true}}

  def content(options = {})
    options = options.merge({:scope => :reports, :metric => self.metric.value})
    I18n.translate(self.key, options)
  end
end
