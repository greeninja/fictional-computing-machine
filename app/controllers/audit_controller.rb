class AuditController < ApplicationController

  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    authorize Audit
    @audits = Audit.sorted
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_week)
    @date_to = parsed_date(params[:date_to], Date.today.next_week)
  end

end
