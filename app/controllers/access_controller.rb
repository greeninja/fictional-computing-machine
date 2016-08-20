class AccessController < ApplicationController

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
    # display text and links
  end

  def login
    # display login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(:username => params[:username]).first
      if found_user
        unless found_user.disabled?
          authorized_user = found_user.authenticate(params[:password])
        end
      end
    end
    if authorized_user
    # Mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      # Check if password needs updating
      if User.find(authorized_user.id).updated_at > Date.today - 90.days
        flash[:notice] = "You are now logged in."
        redirect_to(:controller => 'overview', :action => 'index')
      else
        flash[:warning] = "Your password has expired! Please change it"
        redirect_to(:controller => 'users', :action => 'edit', :id => authorized_user.id)
      end
    else
      flash[:warning] = "Invalid username/password or the account has been disabled."
      redirect_to(:action => 'login')
    end
  end

  def logout
  # Mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => 'login')
  end

private
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(:action => 'login')
      return false # halts the before action
    else
      return true
    end
  end
end
