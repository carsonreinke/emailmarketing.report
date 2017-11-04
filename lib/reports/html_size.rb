require 'reports/size'

module Reports
  class HtmlSize < Size


  protected
    def size(mail_message)
      part = find_part(mail_message, Mime[:html])
      part.nil?() ? nil : part.decoded().bytesize()
    end
  end
end
