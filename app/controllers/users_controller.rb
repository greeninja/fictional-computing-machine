class UsersController < ApplicationController
  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    @users = User.sorted
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize User
  end

  def new
    @user = User.new
    @teams = Team.sorted
    @agents = Agent.sorted
    authorize User
  end

  def create
    authorize User
    @user = User.new(user_params)
    if @user.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "User '#{@user.name}' created successfully"
      redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so user can fix problems
      @teams = Team.sorted
      @agents = Agent.sorted
      render 'new', user: @user, teams: @teams, agents: @agent
    end
  end

  def edit
    @user = User.find(params[:id])
    @agents = Agent.sorted
    @teams = Team.sorted
    authorize @user
  end

  def update
    # Update it
    # If the object updates
    @user = User.find(params[:id])
    authorize @user
    if @user.update(permitted_attributes(@user))
    # If update succeeds, redirect to the index action
      flash[:notice] = "User '#{@user.name}' updated successfully"
      redirect_to(:action => 'show', :id => @user.id)
    else
    # If update fails, redisplay the form so user can fix problems
      @teams = Team.sorted
      @agents = Agent.sorted
      render 'edit', user: @user, teams: @teams, agents: @agents
    end
  end

  def delete
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id]).destroy
    authorize @user
    flash[:notice] = "User '#{@user.name}' deleted successfully"
    redirect_to(:action => 'index')
  end

  private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :role, :disabled, :team_id, :agent_id)
    end
end
