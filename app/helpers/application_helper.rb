module ApplicationHelper

  def ticket_feedback
    result = Ticket.where(:feedback => true).count
  end

  def enabled_models(model)
    if @current_user.team_id != nil
      team = Team.find(@current_user.team_id)
      if model == "rats"
        result = team.rats_enabled?
      elsif model == "ticks"
        result = team.ticks_enabled?
      else model == "qa"
        result = team.qa_enabled?
      end
    else
      result = true
    end
  end

end
