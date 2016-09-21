class QaPolicy < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def all_teams?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader?
  end

  def team?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader?
  end

end
