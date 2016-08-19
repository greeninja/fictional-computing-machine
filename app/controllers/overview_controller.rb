class OverviewController < ApplicationController

  before_action :confirm_logged_in

  def index
    @agents = Agent.count
    # @rats = Agent.rats.count
    # @ticks = Agent.ticks.count
  end
end
