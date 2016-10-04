class CrossPolicy < ApplicationPolicy

  def initialize(current_user, model)
    @current_user = current_user
    @agent = model
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

  def destroy?
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def req_delete?
    return false if @current_user.agent_id == @agent.id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def remove_req?
    return false if @current_user.agent_id == @agent.id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def edit?
    return false if @current_user.agent_id == @agent.id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def update?
    return false if @current_user.agent_id == @agent.id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def permitted_attributes
    unless @current_user.user?
      [:req_delete, :req_reason]
    end
  end

end
