class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :type_lookup, only: [:index, :show]
  before_action :confirm_logged_in
  after_action :verify_authorized

  # Rescue from Not Found error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message


  def index
    if @current_user.team_id?
      @teams = Team.where(:id => @current_user.team_id)
    else
      @teams = Team.all
    end
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_week)
    @date_to = parsed_date(params[:date_to], Date.today.next_week)
    @search = Search.new(params[:search])
    authorize Team
  end

  def show
    if @current_user.team_id?
      @team = Team.where(:id => @current_user.team_id).find(params[:id])
    else
      @team = Team.find(params[:id])
    end
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_week)
    @date_to = parsed_date(params[:date_to], Date.today.next_week)
    @search = Search.new(params[:search])
    authorize Team
  end

  def new
    authorize Team
    @team = Team.new
  end

  def edit
    if @current_user.team_id?
      @team = Team.where(:id => @current_user.team_id).find(params[:id])
    else
      @team = Team.find(params[:id])
    end
    authorize Team
  end

  def create
    @team = Team.new(team_params)
    authorize Team

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Team
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize Team
    if @team.agents.count == 0
      @team.destroy
      respond_to do |format|
        format.html { redirect_to teams_url, notice: 'Team was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      flash[:warning] = "Agents still assigned to this team, so cannot be removed"
      redirect_to(request.referrer || root_path)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :description, :rats_enabled, :ticks_enabled, :qa_enabled)
    end

    def type_lookup
      @tick_types = TickType.sorted
      @rat_types = RatType.sorted
    end

  def not_found_message
    flash[:warning] = "You are either not authorised to perform this action or the record was not found"
    redirect_to(request.referrer || root_path)
  end

end
