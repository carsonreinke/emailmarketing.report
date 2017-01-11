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

  composed_of :mail_message, {:class_name => 'Mail::Message', :mapping => %w(message encoded)}
end
