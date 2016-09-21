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
    month_tickets = agent.tickets.where('tickets.date BETWEEN ? AND ?', @date_from, @date_to).group_by { |m| m.date.beginning_of_month }
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
end
