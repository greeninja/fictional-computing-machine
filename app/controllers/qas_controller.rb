class QasController < ApplicationController

  before_action :set_user, only: [:show, :show_qa, :new, :destroy, :get_setting]
  before_action :get_setting, only: [:show, :show_qa, :new, :create]
  before_action :get_general_settings, only: [:team]
  before_action :set_dates
  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    @setting = Setting.where(:name => "qa_settings").first
    unless @setting.enabled?
      authorize Qa
      flash[:warning] = "This model is not enabled yet."
      redirect_to(request.referrer || root_path)
    else
      if @current_user.team_id?
        @users = Agent.where(:team_id => @current_user.team_id).sorted
        @teams = Agent.uniq_team_id.where(:team_id => @current_user.team_id)
        @teamcount = Team.where(:id => @current_user.team_id).count
      else
        @users = Agent.sorted
        @teams = Agent.uniq_team_id.where.not(:team_id => nil)
        @teamcount = Team.count
      end
      authorize Qa
    end
  end

  def show
    # This uses the Agent policy to determin show.
    authorize @user
    @team = Team.find(@user.team_id)
    @qa_date_from = parsed_date(params[:date_from], 1.month.ago.beginning_of_month.to_date)
    @qa_date_to = parsed_date(params[:date_to], 1.month.ago.end_of_month.to_date)
    @general_settings = QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }").or(QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }"))
  end

  def show_qa
    # This uses the Agent policy to determin show.
    authorize @user
    @team = Team.find(@user.team_id)
    @qa_date_from = parsed_date(params[:date_from], 1.month.ago.beginning_of_month.to_date)
    @qa_date_to = parsed_date(params[:date_to], 1.month.ago.end_of_month.to_date)
    @general_settings = QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }").or(QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }"))
  end

  def all_teams
    @teams = Team.all
    authorize Qa
  end

  def team
    @date_from = 12.months.ago.beginning_of_month
    @date_to = 1.month.ago.end_of_month.to_date
    authorize Qa
  end

  def edit_individual
    @ticket = Ticket.find(params[:id])
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
    @qas = @ticket.qas
    # This uses the ticket policy to edit records
    authorize @ticket
  end

  def update_individual
    @ticket = Ticket.find(params[:id])
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
    authorize @ticket

    if Qa.update(params[:qas].keys, params[:qas].values)
    # Update score total
      score = @ticket.qas.sum(:score)
      total_available = @ticket.qas.sum(:out_of)
      total_score = (score.to_f / total_available.to_f) * 100
      update_score = @ticket.update(:score => total_score)
    # If update succeeds, redirect to the index action
      flash[:notice] = "QA for #{ @ticket.ticket_reference } updated successfully"
      redirect_to(:controller => "qas", :action => 'show', :id => @user, :date_from => @date_from, :date_to => @date_to)
    end
  end

  private

  def set_user
    @user = Agent.find(params[:id])
  end

  def get_setting
    @setting = Setting.where(:name => "qa_settings")
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
  end

  def set_dates
    @date_from = parsed_date(params[:date_from], 1.month.ago.beginning_of_month.to_date)
    @date_to = parsed_date(params[:date_to], 1.month.ago.end_of_month.to_date)
  end

  def qa_params
    params.require(:qa).permit(:score)
  end

  def get_general_settings
    @team = Team.find(params[:id])
    @general_settings = QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }").or(QaGeneralSetting.where("qa_general_settings.disabled = false and qa_general_settings.team_id = #{ @team.id }"))
  end

end

