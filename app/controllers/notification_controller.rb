class NotificationController < ApplicationController
  before_action :confirm_logged_in
  # after_action :verify_authorized

  def index
    @notifications = Notification.where("notifications.recipient = #{@current_user.id}").or(Notification.where("notifications.group = \'#{ current_user.role }\' "))
  end

  def mark_read
    @notification = Notification.find(params[:notification])
    respond_to do |format|
      if @notification.update_attributes(params)
        format.html { redirect_to :index, notice: 'Notification was successfully marked as read.' }
      else
        format.html { render :index }
      end
    end
  end

  private

  def read_params
    params.require(:notification).permit(:read)
  end

end
