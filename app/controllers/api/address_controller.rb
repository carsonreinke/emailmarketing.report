module Api
  class AddressController < BaseController
    def from_local()
      @data = ReportString.where({:key => 'Reports::FromLocalAddress'}).
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
