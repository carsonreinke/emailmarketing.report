module Api
  class EmailsController < BaseController
    caches_action :volume_overtime

    def volume_overtime()
      @data = Email.group_by_day(:sent_at).count()
      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end
  end
end
