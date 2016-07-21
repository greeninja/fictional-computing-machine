class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in

  helper_method :sort_column, :sort_direction

  def index
    @users = User.sorted
    @teams = User.uniq_team_id
  end

  def show
    @users = User.find(params[:id])
  end

  def list
    @users = User.find(params[:id])
  end

  def new
    @user = User.new
    @teams = Team.sorted
  end

  def edit
    @users = User.find(params[:id])
    @users.rats.new
    @teams = Team.sorted
  end
  
  def create
    @user = User.new(user_params)

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
    @user = User.find(params[:id])
    @user.rats.new
  end

  def tick
    @user = User.find(params[:id])
    @user.rats.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :last_name, :team, :team_id, :rats_attributes => [:user_id, :longbreak, :latebreak, :offtask, :other, :_destroy], :ticks_attributes => [:ab, :late, :dynamic, :initiative, :void, :notes, :_destroy])
    end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
