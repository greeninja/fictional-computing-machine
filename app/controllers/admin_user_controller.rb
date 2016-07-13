class AdminUserController < ApplicationController
  
  def index
    @admin_user = AdminUser.sorted
  end

  def show
    @admin_user = AdminUser.sorted
end
