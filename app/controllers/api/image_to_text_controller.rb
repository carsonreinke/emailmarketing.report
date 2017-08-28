module Api
  class ImageToTextController < BaseController
    caches_action :ranges

    def ranges()
      @data = {}
      ReportInteger.where({:key => 'Reports::ImageToTextRatio'}).scoping do
        (0..9).each do |percent|
          @data[
            t('.ranges.percent', {
              :lower => number_to_percentage(percent * 10, {:precision => 0}),
              :upper => number_to_percentage((percent + 1) * 10, {:precision => 0})
            })
          ] = ReportDecimal.
            where(ReportInteger.arel_table[:decimal].gteq(percent / 10.0)).
            where(ReportInteger.arel_table[:decimal].lt((percent / 10.0) + 1)).
            count()
        end
      end

      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end
  end
end
