class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

end
