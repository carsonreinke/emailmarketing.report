module Api
  class DkimController < ApplicationController
    def usage()
      yes, no = nil
      ReportInteger.where({:key => 'Reports::DkimUsage'}).scoping do
        yes, no = ReportInteger.where(ReportInteger.arel_table[:integer].gt(0)).count(),
        ReportInteger.where(ReportInteger.arel_table[:integer].lt(1)).count()
      end
      @data = {t('.yes') => yes, t('.no') => no}
      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end

    def usage_overtime()
      @data = ReportInteger.
        includes(:email).
        where(ReportInteger.arel_table['key'].eq('Reports::DkimUsage')).
        references(:email).
        group_by_day(:'emails.sent_at').
        count()

      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end
  end
end
