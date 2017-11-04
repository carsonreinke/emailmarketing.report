module Api
  class DkimController < BaseController
    caches_action :usage, :usage_overtime
    
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
        where(:key => 'Reports::DkimUsage').
        where(ReportInteger.arel_table[:integer].gt(0)).
        references(:email).
        group_by_day(:'emails.sent_at').
        count()
      @data.merge!(
        ReportInteger.
          includes(:email).
          where(:key => 'Reports::DkimUsage').
          where(ReportInteger.arel_table[:integer].lt(1)).
          references(:email).
          group_by_day(:'emails.sent_at').
          count()
      ) do |key, oldval, newval|
        newval > 0 ? (oldval.to_f() / (newval.to_f() + oldval.to_f()) * 100.0).floor() : 0.0
      end
      respond_to do |format|
        format.json do
          render :json => @data
        end
      end
    end
  end
end
