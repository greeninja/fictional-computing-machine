module AgentsHelper

  def get_agent_pane(pane)
    result = Agent.where(team_id: pane.team_id).sorted
  end

end
