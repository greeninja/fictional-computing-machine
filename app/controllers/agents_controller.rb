class AgentsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :get_types, only: [:show]
  before_action :get_settings
  before_action :confirm_logged_in

  helper_method :sort_column, :sort_direction

  def index
    @users = Agent.sorted
    @teams = Agent.uniq_team_id.where.not(:team_id => nil)
    @byteam = Agent.where(team_id: params[:team_id])
    @teamcount = Team.count
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
    @search = Search.new(params[:search])
  end

  def overview
    @users = Agent.sorted
    @teams = Agent.uniq_team_id.where.not(:team_id => nil)
    @byteam = Agent.where(team_id: params[:team_id])
    @teamcount = Team.count
  end

  def show
    @users = Agent.find(params[:id])
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
    @search = Search.new(params[:search])
  end

  def list
    @users = Agent.find(params[:id])
  end

  def new
    @user = Agent.new
    @teams = Team.sorted
  end

  def edit
    @users = Agent.find(params[:id])
    @teams = Team.sorted
  end

  def create
    @user = Agent.new(user_params)

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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rat
    @user = Agent.find(params[:id])
    @rat_types = RatType.sorted
    @user.rats.new
  end

  def tick
    @user = Agent.find(params[:id])
    @tick_types = TickType.sorted
    @user.rats.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:agent).permit(:name, :last_name, :team, :manual_team, :team_id, :customid,
                                   :rats_attributes => [:rat_type_id, :longbreak, :latebreak, :offtask, :notes, :_destroy],
                                   :ticks_attributes => [:tick_type_id, :ab, :late, :dynamic, :initiative, :void, :notes, :_destroy])
    end

  def sort_column
    Agent.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

#  def sort_direction
#    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
#  end

  def get_settings
    @rat_enabled = Setting.find_by(name: "rat_types")
    @tick_enabled = Setting.find_by(name: "tick_types")
  end

  def get_types
    @rat_types = RatType.sorted
    @tick_types = TickType.sorted
  end

end