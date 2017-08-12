module Api
  class DkimController < ApplicationController
    def usage()
      yes, no = nil
      ReportInteger.where({:key => 'Reports::DkimUsage'}).scoping do
        yes, no = ReportInteger.where(ReportInteger.arel_table[:integer].gt(0)).count(),
        ReportInteger.where(ReportInteger.arel_table[:integer].lt(1)).count()
      end
      respond_to do |format|
        format.json do
          render :json => {:yes => yes, :no => no}
        end
      end
    end

    def usage_overtime()
      ReportInteger.
        includes(:email).
        where(ReportInteger.arel_table['key'].eq('Reports::DkimUsage')).
        group(Email.arel_table['created_at'])
      respond_to :json
    end
  end
end
