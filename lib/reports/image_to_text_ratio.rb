require 'reports/base'

module Reports
  class ImageToTextRatio < Base
    def create(email)
      report = email.report_decimals.find_or_initialize_by({:key => self.class.name})

      #Process inline attachments for reading
      mail_message = ActionMailer::InlinePreviewInterceptor.previewing_email(email.mail_message())

      #Create DOM from HTML message
      part = find_part(mail_message, Mime[:html])
      return if part.nil?()
      doc = Nokogiri::HTML(part.decoded()) do |config|
        config.noerror
      end

      #For the most part copied from SpamAssassin
      #See http://svn.apache.org/viewvc/spamassassin/trunk/lib/Mail/SpamAssassin/Plugin/ImageInfo.pm
      body = doc.css('body').text || ''
      body.gsub!(/\s+/, ' ')
      text_size = body.size()

      image_size = 0
      doc.css('img[src]').each do |element|
        src = element['src']
        begin
          size = FastImage.size(src, {:raise_on_failure => true})
          image_size += (size[0] * size[1]) unless size.nil?()
        rescue
          Rails.logger.warn($!.inspect())
        end
      end

      #Image to text ratio is actually text over image area
      ratio = text_size.to_f() / image_size.to_f() if image_size > 0
      ratio = 1.0 if ratio > 1.0 || image_size < 1

      report.value = ratio
      report.save!()
      report
    end
  end
end
