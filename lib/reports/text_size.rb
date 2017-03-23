require 'reports/size'

module Reports
  class TextSize < Size
    include EmailHelper


  protected
    def size(mail_message)
      part = find_part(mail_message, Mime[:text])
      part.nil?() ? nil : part.decoded().bytesize()
    end
  end
end
