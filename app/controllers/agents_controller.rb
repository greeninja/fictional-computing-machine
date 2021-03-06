class AgentsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :get_types, only: [:show]
  before_action :get_settings
  before_action :set_date
  before_action :confirm_logged_in
  after_action :verify_authorized

  # helper_method :sort_column, :sort_direction

  # Rescue from Not Found error
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  # rescue_from ActionView::Template::Error, with: :template_error

  def index
    if @current_user.team_id?
      @users = Agent.where(:team_id => @current_user.team_id).where(:disabled => false).sorted
      @teams = Agent.uniq_team_id.where(:team_id => @current_user.team_id)
      @byteam = Agent.where(:team_id => @current_user.team_id)
      @teamcount = Team.where(:id => @current_user.team_id).count
    else
      @users = Agent.where(:disabled => false).sorted
      @teams = Agent.uniq_team_id.where.not(:team_id => nil)
      @byteam = Agent.where(team_id: params[:team_id])
      @teamcount = Team.count
    end
    authorize Agent
  end

  def manage_agents
    @users = Agent.sorted
    @teams = Agent.uniq_team_id.where.not(:team_id => nil)
    @byteam = Agent.where(team_id: params[:team_id])
    @teamcount = Team.count
    authorize Agent
  end

  def overview
    @users = Agent.sorted
    @teams = Agent.uniq_team_id.where.not(:team_id => nil)
    @byteam = Agent.where(team_id: params[:team_id])
    @teamcount = Team.count
    authorize Agent
  end

  def show
    if @current_user.user?
      if Agent.exists?(@current_user.agent_id)
        @users = Agent.find(@current_user.agent_id)
        @user_ticks = @user.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
        @user_crosses = @user.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
        @team = Team.find(@user.team_id)
        @team_ticks = @team.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
        @team_crosses = @team.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
      end
    elsif @current_user.supervisor?
      if Agent.exists?(@current_user.agent_id)
        @users = Agent.find(params[:id])
        @user_ticks = @user.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
        @user_crosses = @user.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
        @team = Team.find(@users.team_id)
        @team_ticks = @team.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
        @team_crosses = @team.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
      end
    elsif @current_user.team_id?
      @users = Agent.where(:team_id => @current_user.team_id).find(params[:id])
    else
      @users = Agent.find(params[:id])
    end
    @agent = @user
    authorize @agent
  end

  def list
    @users = Agent.find(params[:id])
  end

  def new
    @user = Agent.new
    @teams = Team.sorted
    authorize Agent
  end

  def edit
    @users = Agent.find(params[:id])
    @teams = Team.sorted
    authorize @users
  end

  def create
    @user = Agent.new(user_params)
    authorize Agent
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Agent
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize Agent
    @user.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cross
    # authorize Agent
    if @current_user.team_id?
      @user = Agent.where(:team_id => @current_user.team_id).find(params[:id])
    else
      @user = Agent.find(params[:id])
    end
    authorize @user
    @cross_types = CrossType.sorted
    @user.crosses.new
  end

  def tick
    # authorize Agent
    if @current_user.team_id?
      @user = Agent.where(:team_id => @current_user.team_id).find(params[:id])
    else
      @user = Agent.find(params[:id])
    end
    authorize @user
    @tick_types = TickType.sorted
    @user.ticks.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:agent).permit(:name, :last_name, :team, :manual_team, :team_id, :customid, :disabled,
                                   :crosses_attributes => [:cross_type_id, :longbreak, :latebreak, :offtask, :notes, :_destroy],
                                   :ticks_attributes => [:tick_type_id, :ab, :late, :dynamic, :initiative, :void, :notes, :_destroy])
    end

  def sort_column
    Agent.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def get_settings
    @cross_enabled = Setting.find_by(name: "cross_types")
    @tick_enabled = Setting.find_by(name: "tick_types")
  end

  def get_types
    @cross_types = CrossType.sorted
    @tick_types = TickType.sorted
  end

  def not_found_message
    flash[:warning] = "You are either not authorised to perform this action or the record was not found"
    redirect_to(request.referrer || root_path)
  end

  def template_error
    flash[:warning] = "Something went wrong rendering the template. Have you selected an option?"
    redirect_to(request.referrer || root_path)
  end

  def set_date
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_week)
    @date_to = parsed_date(params[:date_to], Date.today.next_week)
  end

end
