class BroadcastPolicy < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    unless @current_user.disabled?
      return true
    end
  end

  def mark_read?
    @current_user.admin?
    @current_user.junior_admin?
  end

end
