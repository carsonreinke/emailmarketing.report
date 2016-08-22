class Email < Application
  attr_accessor :site_id, :message

  belongs_to :site
  has_many :reports

  def mail_message()
    @mail_message ||= Mail::Message.new(self.message)
  end
end