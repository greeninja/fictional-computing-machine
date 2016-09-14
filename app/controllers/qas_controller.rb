class QasController < ApplicationController

  before_action :set_user, only: [:show, :new, :destroy, :get_setting]
  before_action :get_setting, only: [:show, :new, :create]
  before_action :set_dates

  def index
    @users = Agent.sorted
    @teams = Agent.uniq_team_id.where.not(:team_id => nil)
    @teamcount = Team.count
  end

  def show
  end

  def edit
    @ticket = Ticket.find(params[:ticket_id])
    @qas = @ticket.qas
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
  end

  def update
    @ticket = Ticket.find(params[:ticket_id])
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted

    @ticket.qas.each do |qa|
      qa.update_attributes!(params[:qas].reject { |k,v| v.blank? })
    end
    flash[:notice] = "Updated QA Criteria"
    redirect_to(:action => 'show', :id => @user.id)
  end

  def new
    @qa = Qa.new
    @ticket = Ticket.new
  end

  def create
    @qa = Qa.new(qa_params)
    if @qa.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "Qa created successfully"
      redirect_to(:action => 'show', :id => @user.id )
    else
    # If save fails, redisplay the form so user can fix problems
      render 'new', user: @user
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
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
  end

  def qa_params
    params.require(:qa).permit()
  end

end

