require 'reports/html_size'

module Reports
  class HtmlDownloadedSize < HtmlSize
    include EmailHelper


  protected
    def size(mail_message)
      _size = super(mail_message)
      return nil if _size.nil?()

      part = find_part(mail_message, Mime[:html])
      html = part.decoded()
      doc = Nokogiri::HTML(html) do |config|
        config.noerror
      end
      urls = doc.css('[src^="http"]').map do |element|
        begin
          URI.parse(element['src'])
        rescue
          Rails.logger.warn($!.inspect())
          nil
        end
      end
      urls.compact!()

      client = HTTPClient.new()
      urls.each do |url|
        begin
          client.get(url, {:follow_redirect => true}) do |chunk|
            _size += chunk.bytesize()
          end
        rescue
          Rails.logger.warn($!.inspect())
        end
      end

      _size
    end
  end
end
