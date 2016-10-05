module OverviewHelper

  def get_cross_percentages(agent)
    get_crosses = agent.crosses.where('crosses.created_at BETWEEN ? AND ?', @date_from, @date_to)
    if get_crosses.nil?
      count = 0
    else
      count = get_crosses.count.to_f
    end
    if @team_crosses.nil?
      full_percent = 0
    else
      full_percent = count / @team_crosses * 100
    end
    if full_percent.nan?
      @cpercent = 0
    else
      @cpercent = full_percent.nil? ? "0" : full_percent.round
    end
    @cnumber_of = count.nil? ? "0" : count.round
  end

  def get_tick_percentages(agent)
    get_ticks = agent.ticks.where('ticks.created_at BETWEEN ? AND ?', @date_from, @date_to)
    if get_ticks.nil?
      count = 0
    else
      count = get_ticks.count.to_f
    end
    if @team_ticks.nil?
      full_percent = 0
    else
      full_percent = count / @team_ticks * 100
    end
    if full_percent.nan?
      @tpercent = 0
    else
      @tpercent = full_percent.nil? ? "0" : full_percent.round
    end
    @tnumber_of = count.nil? ? "0" : count.round
  end

end
