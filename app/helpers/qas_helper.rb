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

end
