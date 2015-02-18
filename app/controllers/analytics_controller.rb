class AnalyticsController < ApplicationController
  def show
    @analytics = Analytic.find(params[:id])
  end
end
