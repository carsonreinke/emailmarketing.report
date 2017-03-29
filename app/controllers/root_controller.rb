class RootController < ApplicationController
  def index
    #All charts mapped by key
    @charts = Hash[Chart.all.map{|chart| [chart.key, chart]}]
  end
end
