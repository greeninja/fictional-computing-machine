class AuditController < ApplicationController

  before_action :confirm_logged_in

  def index
    @audits = Audit.sorted
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
  end

end