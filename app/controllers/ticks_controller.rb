class TicksController < ApplicationController
  before_action :set_tick, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    @ticks = Tick.all
    authorize Tick
  end

  def show
    authorize Tick
  end

  def new
    @tick = Tick.new
    authorize Tick
  end

  def edit
    @agent = Agent.find(@tick.agent_id)
    authorize @agent
  end

  def create
    @tick = Tick.new(tick_params)
    authorize Tick

    respond_to do |format|
      if @tick.save
        format.html { redirect_to @tick, notice: 'Tick was successfully created.' }
        format.json { render :show, status: :created, location: @tick }
      else
        format.html { render :new }
        format.json { render json: @tick.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Tick
    @user = Agent.find(@tick.agent_id)
      if @tick.update(permitted_attributes(@tick))
        @notify = Notification.new(:controller => "tick", :item => "#{ @tick.id }", :creator => "#{ @current_user.id }", :message => "has requested deletion of a Tick", :junior_admin => true, :admin => true)
        if @notify.save
          flash[:notice] = "Marked tick for deletion"
          redirect_to(:controller => "agents", :action => "show", :id => @tick.agent_id)
        else
          flash[:warning] = "Error in notification!"
        end
      else
        format.html { render :edit, warning: 'Error in form' }
        format.json { render json: @tick.errors, status: :unprocessable_entity }
      end
  end

  def remove_req
    authorize Tick
    @tick = Tick.find(params[:id])
    @tick.req_delete = false
    @tick.req_reason = nil
    if @tick.save
      # Post notificaiton to Admins
      @notify = Notification.new(:controller => "tick", :item => "#{ @tick.id }", :creator => "#{ @current_user.id }", :message => "has removed request to delete a Tick", :junior_admin => true, :admin => true)
      if @notify.save
        flash[:notice] = "Cleared delete request"
        redirect_to(:controller => "agents", :action => "show", :id => @tick.agent_id)
      else
        flash[:warning] = "Error in notification!"
      end
    else
      flash[:warning] = "Couldn't unmark tick for deletion."
    end
  end

  def destroy
    authorize Tick
    @tick.destroy
    @user = Agent.find(params[:agent_id])
    respond_to do |format|
      format.html { redirect_to agent_path(@user), notice: 'Tick was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tick
      @tick = Tick.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tick_params
      params.fetch(:tick, {})
    end
end
