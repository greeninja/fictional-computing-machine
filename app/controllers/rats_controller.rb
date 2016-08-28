class RatsController < ApplicationController
  before_action :set_rat, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  before_filter :get_user

  def get_user
    @user = Agent.find(params[:agent_id]) if params[:agent_id]
  end

  def index
    @rats = Rat.all
    authorize Rat
  end

  def show
    authorize Rat
  end

  def new
    @rat = Rat.new
    authorize Rat
  end

  def edit
    authorize Rat
  end

  def create
    @rat = Rat.new(rat_params)
    authorize Rat

    respond_to do |format|
      if @rat.save
        format.html { redirect_to @rat, notice: 'Rat was successfully created.' }
        format.json { render :show, status: :created, location: @rat }
      else
        format.html { render :new }
        format.json { render json: @rat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Rat
    @user = Agent.find(@rat.agent_id)
      if @rat.update(permitted_attributes(@rat))
        @notify = Notification.new(:controller => "rat", :item => "#{ @rat.id }", :creator => "#{ @current_user.id }", :message => "has requested deletion of a Rat", :junior_admin => true, :admin => true)
        if @notify.save
          flash[:notice] = "Marked rat for deletion"
          redirect_to(:controller => "agents", :action => "show", :id => @rat.agent_id)
        else
          flash[:warning] = "Error in notification!"
        end
      else
        format.html { render :edit, warning: 'Error in form' }
        format.json { render json: @rat.errors, status: :unprocessable_entity }
      end
  end

  def destroy
    authorize Rat
    @rat.destroy
    @user = Agent.find(params[:agent_id])
    respond_to do |format|
      format.html { redirect_to agent_path(@user), notice: 'Rat was successfully deleted' }
      format.json { head :no_content }
    end
  end

  def remove_req
    authorize Rat
    @rat = Rat.find(params[:id])
    @rat.req_delete = false
    @rat.req_reason = nil
    if @rat.save
      # Post notificaiton to Admins
      @notify = Notification.new(:controller => "rat", :item => "#{ @rat.id }", :creator => "#{ @current_user.id }", :message => "has removed request to delete a Rat", :junior_admin => true, :admin => true)
      if @notify.save
        flash[:notice] = "Cleared request to delete Rat"
        redirect_to(:controller => "agents", :action => "show", :id => @rat.agent_id)
      else
        flash[:warning] = "Error in notification!"
      end
    else
      flash[:warning] = "Couldn't unmark rat for deletion."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rat
      @rat = Rat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rat_params
      # params.fetch(:rat, {})
      params.require(:rat).permit(:req_delete, :req_reason)
    end
end
