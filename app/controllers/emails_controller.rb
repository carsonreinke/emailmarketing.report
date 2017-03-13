#
# Copied from Rails
# https://github.com/rails/rails/blob/master/railties/lib/rails/mailers_controller.rb
#
class EmailsController < ApplicationController
  include EmailHelper

  def show()
    @email = Email.find(params[:id]).mail_message()

    #cid to inline data URLs
    @email = ActionMailer::InlinePreviewInterceptor.previewing_email(@email)

    if params[:part]
      @part_type = Mime::Type.lookup(params[:part])

      if part = find_part(@email, @part_type)
        response.content_type = @part_type
        render plain: part.respond_to?(:decoded) ? part.decoded : part
      else
        raise AbstractController::ActionNotFound, "Email part '#{@part_type}' not found"
      end
    else
      @part = find_preferred_part(@email, request.format, Mime[:html], Mime[:text])
      @part_type = Mime::Type.lookup(@part.mime_type || request.format)
      render layout: false, formats: %w[html]
    end
  end
end
