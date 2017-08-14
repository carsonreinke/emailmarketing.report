class Email < ApplicationRecord
  #attr_accessor :site_id, :message

  belongs_to :site, :dependent => :destroy
  has_many :reports, :dependent => :destroy
  has_many :report_decimals, :dependent => :destroy, :class_name => 'ReportDecimal'
  has_many :report_integers, :dependent => :destroy, :class_name => 'ReportInteger'
  has_many :report_strings, :dependent => :destroy, :class_name => 'ReportString'

  validates :site, {:presence => true}
  validate do #TODO Better validation
    begin
      self.mail_message()
    rescue
      errors.add(:message, :format)
    end
  end
  validates :sent_at, {:presence => true}

  composed_of :mail_message, {:class_name => 'Mail::Message', :mapping => %w(message encoded)}

  before_validation do
    self.sent_at ||= self.mail_message.date rescue Time.zone.now
  end
end
