class EmailsController < ApplicationController
  def show()
    @email = Email.find(params[:id]).mail_message()

    if params[:part]
      part_type = Mime::Type.lookup(params[:part])

      if part = find_part(part_type)
        response.content_type = part_type
        render plain: part.respond_to?(:decoded) ? part.decoded : part
      else
        raise AbstractController::ActionNotFound, "Email part '#{part_type}' not found in #{@preview.name}##{@email_action}"
      end
    else
      @part = find_preferred_part(request.format, Mime[:html], Mime[:text])
      render layout: false, formats: %w[html]
    end
  end


private

    def find_preferred_part(*formats) # :doc:
      formats.each do |format|
        if part = @email.find_first_mime_type(format)
          return part
        end
      end

      if formats.any? { |f| @email.mime_type == f }
        @email
      end
    end

    def find_part(format) # :doc:
      if part = @email.find_first_mime_type(format)
        part
      elsif @email.mime_type == format
        @email
      end
    end
end
