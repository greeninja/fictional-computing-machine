class AgentPolicy < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def show?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def create?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader?
  end

  def update?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def rat?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def tick?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def destroy?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader?
  end

end
