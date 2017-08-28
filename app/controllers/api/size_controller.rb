module Api
  class SizeController < BaseController
    caches_action :average_sizes

    def average_sizes()
      @data = {}
      ReportInteger.where(ReportInteger.arel_table[:integer].gt(0)).scoping do
        @data = {
          t('.size') => ReportInteger.where({:key => 'Reports::Size'}).average(:integer).floor(),
          t('.html_size') => ReportInteger.where({:key => 'Reports::HtmlSize'}).average(:integer).floor(),
          t('.html_downloaded_size') => ReportInteger.where({:key => 'Reports::HtmlDownloadedSize'}).average(:integer).floor(),
          t('.text_size') => ReportInteger.where({:key => 'Reports::TextSize'}).average(:integer).floor()
        }
      end

      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end
  end
end
