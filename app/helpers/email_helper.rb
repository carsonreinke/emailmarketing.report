module EmailHelper
  def find_preferred_part(mail_message, *formats) # :doc:
    formats.each do |format|
      if part = mail_message.find_first_mime_type(format)
        return part
      end
    end

    if formats.any? { |f| mail_message.mime_type == f }
      mail_message
    end
  end

  def find_part(mail_message, format) # :doc:
    if part = mail_message.find_first_mime_type(format)
      part
    elsif mail_message.mime_type == format
      mail_message
    end
  end
end
