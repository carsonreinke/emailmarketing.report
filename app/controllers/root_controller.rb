class RootController < ApplicationController
  def index
    @reports = {:dkim => reports_dkim()}


  end

protected
  def reports_dkim()
    <<-COMMENT
    Metric::Counter.includes(:report).where(Report.arel_table[:key].eq('Reports::Size')).references(:report).scoping do
      {
        :yes => Metric::Counter.where(Metric::Counter.arel_table[:value].gt(0)).count(),
        :no => Metric::Counter.where(Metric::Counter.arel_table[:value].lt(1)).count()
      }
    end
    COMMENT
  end
end
