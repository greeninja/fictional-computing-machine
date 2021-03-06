class OverviewController < ApplicationController

  before_action :set_dates
  before_action :set_qa_dates
  before_action :confirm_logged_in

  def index
    @agents = Agent.count
    # @crosses = Agent.crosses.count
    # @ticks = Agent.ticks.count

    if @current_user.agent_id?
      @agent = Agent.find(@current_user.agent_id)
      @team = Team.find(@agent.team_id)
      @general_settings = QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }").or(QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }"))
      @get_team_crosses = @team.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
      if @get_team_crosses.nil?
        @team_crosses = 0
      else
        @team_crosses = @get_team_crosses.count
      end
      @get_team_ticks = @team.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
      if @get_team_ticks.nil?
        @team_ticks = 0
      else
        @team_ticks = @get_team_ticks.count
      end
    end
  end

  private

  def set_dates
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
  end

  def set_qa_dates
    @qa_date_from = parsed_date(params[:qa_date_from], 3.months.ago.beginning_of_month)
    @qa_date_to = parsed_date(params[:qa_date_to], 1.month.ago.end_of_month.to_date)
  end

end
