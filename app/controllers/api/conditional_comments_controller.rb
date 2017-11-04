module Api
  class ConditionalCommentsController < BaseController
    caches_action :feature_version

    def feature_version()
      @data = ReportString.where({:key => 'Reports::ConditionalComments'}).
        group(:string).
        order(ReportString.arel_table[:string].count.desc).
        limit(5).
        count(:string)
      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end
  end
end
