class BroadcastsController < ApplicationController
  before_action :set_broadcast, only: [:edit, :update, :mark_read]
  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    @broadcasts = Broadcast.where(:read => false)
    # @broadcasts = Broadcast.all
    authorize Broadcast
  end

  def update
    authorize Broadcast
    respond_to do |format|
      if @broadcast.update(broadcast_params)
        format.html { redirect_to @broadcast, notice: 'Broadcast was successfully updated.' }
        format.json { render :show, status: :ok, location: @broadcast }
      else
        format.html { render :edit }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_read
    authorize Broadcast
    @broadcast.read = "true"
    if @broadcast.save
      flash[:notice] = "Marked as read"
      redirect_to(:action => 'index')
    else
      flash[:error] = "Something went wrong trying to mark as read"
      redirect_to(:action => 'index')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_broadcast
      @broadcast = Broadcast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def broadcast_params
      params.fetch(:broadcast, {})
    end
end
