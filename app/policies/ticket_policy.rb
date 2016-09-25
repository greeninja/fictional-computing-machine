class TicketPolicy < ApplicationPolicy

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @ticket = model
  end

  def new?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def create?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def qa?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def edit?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def update?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def delete?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def destroy?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def edit_individual?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def update_individual?
    return false if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def feedback?
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

  def req_feedback?
    return true if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin?
  end

  def clear_feedback?
    return true if @current_user.agent_id == @ticket.agent_id
    @current_user.admin? or
    @current_user.junior_admin? or
    @current_user.team_leader? or
    @current_user.supervisor?
  end

end
