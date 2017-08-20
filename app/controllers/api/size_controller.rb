module Api
  class SizeController < ApplicationController
    def average_sizes()
      @data = {}
      ReportInteger.where(ReportInteger.arel_table[:integer].gt(0)).scoping do
        @data = {
          t('.size') => ReportInteger.where({:key => 'Reports::Size'}).average(:integer),
          t('.html_size') => ReportInteger.where({:key => 'Reports::HtmlSize'}).average(:integer),
          t('.html_downloaded_size') => ReportInteger.where({:key => 'Reports::HtmlDownloadedSize'}).average(:integer),
          t('.text_size') => ReportInteger.where({:key => 'Reports::TextSize'}).average(:integer)
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
