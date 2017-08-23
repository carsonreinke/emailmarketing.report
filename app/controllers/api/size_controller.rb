module Api
  class SizeController < ApplicationController
    include ActionView::Helpers::NumberHelper

    caches_action :average_sizes, :image_to_text

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

    def image_to_text_ranges()
      @data = {}
      ReportInteger.where({:key => 'Reports::ImageToTextRatio'}).scoping do
        (0..9).each do |percent|
          @data[
            t('.image_to_text_ranges.percent', {
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
