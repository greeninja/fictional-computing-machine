module QasHelper

  def get_months
    result = []
    @date_from.to_date.upto(@date_to) do |a|
      result << [a.month,a.year]
    end
    result.uniq!
  end

end
