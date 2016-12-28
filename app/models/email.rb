class Email < ApplicationRecord
  #attr_accessor :site_id, :message

  belongs_to :site
  has_many :reports

  validates :site, {:presence => true}
  validate do #TODO Better validation
    begin
      self.mail_message()
    rescue
      errors.add(:message, :format)
    end
  end

  def mail_message()
    @mail_message ||= Mail::Message.new(self.message)
  end
end
