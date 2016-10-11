module OverviewHelper

########## Ticks and Cross Helpers

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

########## QA Helpers

  def ov_qa_average(user)
    tickets = user.tickets.where('tickets.date BETWEEN ? AND ?', @qa_date_from, @qa_date_to)
    total = tickets.sum(:score)
    result = total.to_f / tickets.count
    result.nan? ? "0" : result.round
  end

  def ov_qa_team_average(team)
    tickets = team.tickets.where('tickets.date BETWEEN ? AND ?', @qa_date_from, @qa_date_to)
    total = tickets.sum(:score)
    result = total.to_f / tickets.count
    result.nan? ? "0" : result.round
  end

  def ov_badge_it(score)
    unless @general_settings.empty?
      unless @general_settings.where(:name => "year_view_yellow_badge").empty?
        yellow_score = @general_settings.where(:name => "year_view_yellow_badge").first
      end
      unless @general_settings.where(:name => "year_view_green_badge").empty?
        green_score = @general_settings.where(:name => "year_view_green_badge").first
      end
      unless @general_settings.where(:name => "year_view_red_badge").empty?
        red_score = @general_settings.where(:name => "year_view_red_badge").first
      end

      if score.to_f >= green_score.value.to_f
        badge = "success"
      elsif score.to_f >= yellow_score.value.to_f and score < green_score.value.to_f
        badge = "warning"
      elsif score.to_f <= red_score.value.to_f
        badge = "danger"
      else
        badge = "default"
      end

      result = "<div class=\"progress-bar progress-bar-#{ badge }\" role=\"progressbar\" aria-valuenow=\"#{ score }\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"min-width: 2em; width: #{ score }%;\">"
      result.html_safe

    else
      result = "<div class=\"progress-bar\" role=\"progressbar\" aria-valuenow=\"#{ score }\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"min-width: 2em; width: #{ score }%;\">"
      result.html_safe
    end
  end

end
