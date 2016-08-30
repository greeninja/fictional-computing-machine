class UserPolicy < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user == @user
  end

  def show?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user == @user
  end

  def edit?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user == @user
  end

  def create?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def update?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user == @user
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def permitted_attributes
    if @current_user.admin? or @current_user.junior_admin?
      [:first_name, :last_name, :username, :email, :password, :role, :disabled, :agent_id, :team_id, :password_confirmation, :password_changed]
    else
      [:first_name, :last_name, :username, :email, :password, :password_confirmation, :password_changed]
    end
  end

end
