class CrossesController < ApplicationController
  before_action :set_cross, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  before_filter :get_user

  def get_user
    @user = Agent.find(params[:agent_id]) if params[:agent_id]
  end

  def index
    @crosses = Cross.all
    authorize Cross
  end

  def show
    authorize Cross
  end

  def new
    @cross = Cross.new
    authorize Cross
  end

  def edit
    @agent = Agent.find(@cross.agent_id)
    authorize @agent
  end

  def create
    @cross = Cross.new(cross_params)
    authorize Cross

    respond_to do |format|
      if @cross.save
        format.html { redirect_to @cross, notice: 'Cross was successfully created.' }
        format.json { render :show, status: :created, location: @cross }
      else
        format.html { render :new }
        format.json { render json: @cross.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = Agent.find(@cross.agent_id)
    authorize @user
      if @cross.update(permitted_attributes(@cross))
        @notify = Notification.new(:controller => "cross", :item => "#{ @cross.id }", :creator => "#{ @current_user.id }", :message => "has requested deletion of a Cross", :junior_admin => true, :admin => true)
        if @notify.save
          flash[:notice] = "Marked cross for deletion"
          redirect_to(:controller => "agents", :action => "show", :id => @cross.agent_id)
        else
          flash[:warning] = "Error in notification!"
        end
      else
        format.html { render :edit, warning: 'Error in form' }
        format.json { render json: @cross.errors, status: :unprocessable_entity }
      end
  end

  def destroy
    authorize Cross
    @cross.destroy
    @user = Agent.find(params[:agent_id])
    respond_to do |format|
      format.html { redirect_to agent_path(@user), notice: 'Cross was successfully deleted' }
      format.json { head :no_content }
    end
  end

  def remove_req
    @cross = Cross.find(params[:id])
    @agent = Agent.find(@cross.agent_id)
    @user = Agent.find(@cross.agent_id)
    authorize @user
    @cross.req_delete = false
    @cross.req_reason = nil
    if @cross.save
      # Post notificaiton to Admins
      @notify = Notification.new(:controller => "cross", :item => "#{ @cross.id }", :creator => "#{ @current_user.id }", :message => "has removed request to delete a Croxx", :junior_admin => true, :admin => true)
      if @notify.save
        flash[:notice] = "Cleared request to delete Cross"
        redirect_to(:controller => "agents", :action => "show", :id => @cross.agent_id)
      else
        flash[:warning] = "Error in notification!"
      end
    else
      flash[:warning] = "Couldn't unmark cross for deletion."
    end
  end


  private
    def set_cross
      @cross = Cross.find(params[:id])
    end

    def cross_params
      params.require(:cross).permit(:req_delete, :req_reason)
    end
end
