module TicketsHelper

  def get_dates(ticket)
    @date_from = ticket.date.beginning_of_month.to_s
    @date_to = ticket.date.end_of_month.to_s
  end

end
