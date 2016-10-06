module QasHelper

  def get_months
    result = []
    month = []
    mons = []
    @date_from.to_date.upto(@date_to) do |a|
      result << ["01-#{sprintf '%02d', a.month}-#{a.year}"]
    end
    result.uniq!
  end

  def parse_months(month)
    d = Date.parse(month)
    d.to_date
  end

  def qa_average(user)
    tickets = user.tickets.where('tickets.date BETWEEN ? AND ?', @date_from, @date_to)
    total = tickets.sum(:score)
    result = total.to_f / tickets.count
    result.nan? ? "No Results for Time range" : result.round
  end

  def tickets_by_month(agent)
    result = []
    month_tickets = agent.tickets.where('tickets.score != "NULL" and tickets.date BETWEEN ? AND ?', @date_from, @date_to).group_by { |m| m.date.beginning_of_month }
    month_tickets.sort.each do | month, ticket |
      total_score = ticket.map {|s| s['score']}.reduce(0, :+)
      result << {
        agent: agent.id,
        month: month.to_s,
        score: total_score.to_f / ticket.count
      }
    end
    result
  end

  def badge_it(score)
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

      if score >= green_score.value.to_f
        badge = "success"
      elsif score >= yellow_score.value.to_f and score < green_score.value.to_f
        badge = "warning"
      elsif score <= red_score.value.to_f
        badge = "danger"
      else
        badge = "default"
      end

      result = "<h4><span class=\"label label-#{badge}\">#{ score } %</span></h4>"
      result.html_safe

    else
      score
    end
  end

  def itemised_tickets(group, criteria, date)
    result = []
    score = 0
    tickets = @user.tickets.where('tickets.date BETWEEN ? AND ?', date, date.end_of_month).order('tickets.created_at asc')
    group.tickets.where('tickets.date BETWEEN ? AND ?', date, date.end_of_month).order('tickets.created_at asc').each do |ticket|
      score += ticket.qas.where(:qa_setting_id => criteria.id).map {|s| s['score']}.reduce(0, :+)
    end
    total_available = criteria.out_of * tickets.count
    result = ((score.to_f / total_available.to_f) * 100).round
    result
  end

  def itemised_ticket(ticket, criteria)
    result = []
    score = 0
    score = ticket.qas.where(:qa_setting_id => criteria.id).map {|s| s['score']}.reduce(0, :+)
    total_available = criteria.out_of
    result = ((score.to_f / total_available.to_f) * 100).round
    result
  end

end
