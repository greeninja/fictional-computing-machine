module AgentsHelper

  def get_agent_pane(pane)
    result = Agent.where(team_id: pane.team_id).sorted
  end

  def agent_get_cross_percentages(agent)
    get_crosses = agent.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
    if get_crosses.nil?
      count = 0
    else
      count = get_crosses.count.to_f
    end
    if @team_crosses.nil? or @team_crosses.empty?
      full_percent = 0
    else
      full_percent = count / @team_crosses.count * 100
    end
    result = full_percent.round
  end

  def agent_get_tick_percentages(agent)
    get_ticks = agent.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
    if get_ticks.nil?
      count = 0
    else
      count = get_ticks.count.to_f
    end
    if @team_ticks.nil? or @team_ticks.empty?
      full_percent = 0
    else
      full_percent = count / @team_ticks.count * 100
    end
    result = full_percent.nil? ? "0" : full_percent.round
  end

end
