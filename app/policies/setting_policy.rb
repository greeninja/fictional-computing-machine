class SettingPolicy < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def show?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def create?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def update?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def destroy?
    @current_user.admin? or
    @current_user.junior_admin?
  end

end
