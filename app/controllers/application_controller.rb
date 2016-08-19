class ApplicationController < ActionController::Base

  include Pundit

  protect_from_forgery with: :exception
  before_filter :set_paper_trail_whodunnit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  private
    def confirm_logged_in
      unless session[:user_id]
        flash[:notice] = "Please log in"
        redirect_to(:controller => 'access', :action => 'login')
        return false # halts the before action
      else
        return true
      end
    end

    def parsed_date(date_string, default)
      Date.parse(date_string)
    rescue ArgumentError, TypeError
      default
    end

    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
