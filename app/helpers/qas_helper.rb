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
    result.nan? ? "No Results for Time range" : result
  end
end
