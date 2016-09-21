class NotificationController < ApplicationController
  before_action :confirm_logged_in
  # after_action :verify_authorized

  def index
    @notifications = Notification.where("notifications.recipient = #{@current_user.id}").or(Notification.where("notifications.#{@current_user.role} = true ")).where("notifications.read != true").sorted
    @read_notifications = Notification.where("notifications.recipient = #{@current_user.id}").or(Notification.where("notifications.#{@current_user.role} = true ")).where("notifications.read = true").sorted.limit(20)
  end

  def mark_read
    @notification = Notification.find(params[:id])
    @notification.read = "true"
    if @notification.save
      flash[:notice] = "Marked as read"
      redirect_to(:action => 'index')
    else
      flash[:error] = "Something went wrong trying to mark as read"
      redirect_to(:action => 'index')
    end
  end

  private

  def read_params
    params.require(:notification).permit(:read)
  end

end
