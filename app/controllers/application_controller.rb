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
end
