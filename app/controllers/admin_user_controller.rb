class AdminUserController < ApplicationController
  # before_action :confirm_logged_in
    
  def index
    @users = AdminUser.sorted
  end

  def new
    @user = AdminUser.new
  end

  def create
    @user = AdminUser.new(user_params)
    if @user.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "User '#{@user.name}' created successfully"
      redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so user can fix problems
    render('new')
    end
  end
    
  def edit
      @user = AdminUser.find(params[:id])
  end

  def update
    # Update it
    # If the object updates
    @user = AdminUser.find(params[:id])
    if @user.update_attributes(user_params)
    # If update succeeds, redirect to the index action
        flash[:notice] = "Subject '#{@user.name}' updated successfully"
        redirect_to(:action => 'index')
    else
    # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end
    

  def delete
      @user = AdminUser.find(params[:id])
  end

    def destroy
      @user = AdminUser.find(params[:id]).destroy
      flash[:notice] = "User '#{@user.name}' deleted successfully"
      redirect_to(:action => 'index')
    end
    
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
    end
end
