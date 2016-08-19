class OverviewController < ApplicationController

  before_action :confirm_logged_in

  def index
    @agents = Agent.count
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_week)
    @date_to = parsed_date(params[:date_to], Date.today.next_week)
    # @rats = Agent.rats.count
    # @ticks = Agent.ticks.count
  end
end
