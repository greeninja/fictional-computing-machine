class TicketsController < ApplicationController

  before_action :set_user, only: [:show, :new, :qa]
  before_action :set_ticket, only: [:edit, :qa, :update, :delete, :destroy, :req_feedback, :clear_feedback]
  before_action :get_setting, only: [:show, :new, :qa]
  before_action :set_dates
  before_action :confirm_logged_in
  after_action :verify_authorized

  def new
    @ticket = Ticket.new
    @user = Agent.find(params[:agent_id])
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
    authorize Ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
    authorize @ticket
    if @ticket.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "Ticket '#{@ticket.ticket_reference}' successfully added"
      redirect_to(:action => "qa", :id => @ticket.id, agent_id: @ticket.agent_id, date_from: @date_from, date_to: @date_to)
    else
    # If save fails, redisplay the form so user can fix problems
      render 'new'
    end
  end

  def qa
    authorize @ticket
    @ticket.qas.new
  end

  def edit
    @user = Agent.find(@ticket.agent_id)
    authorize @ticket
  end

  def update
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
    authorize @ticket

    if @ticket.update(ticket_params)
    # Update score total
      score = @ticket.qas.sum(:score)
      total_available = @qa_settings.sum(:out_of)
      total_score = (score.to_f / total_available.to_f) * 100
      update_score = @ticket.update(:score => total_score)
    # If update succeeds, redirect to the index action
      flash[:notice] = "QA for #{ @ticket.ticket_reference } created successfully"
      redirect_to(:controller => "qas", :action => 'show', :id => @user.id, date_from: @date_from, date_to: @date_to)
    else
    # If update fails, redisplay the form so user can fix problems
      @ticket = Ticket.find(params[:id])
      @user = Agent.find(@ticket.agent_id)
      flash[:warning] = "All QA Items need to be filled out"
      render 'qa', ticket: @ticket
    end

  end

  def feedback
    authorize Ticket
    @tickets = Ticket.where(:feedback => true)
  end

  def req_feedback
    @user = Agent.find(@ticket.agent_id)
    authorize @ticket
    if @ticket.update(:feedback => true)
      # @notify = Notification.new(:controller => "ticket", :item => "#{ @ticket.id }", :creator => "#{ @current_user.id }", :message => "has requested feedback on #{@ticket.ticket_reference}", :team_leader => true, :supervisor => true)
      # if @notify.save
        flash[:notice] = "Feedback requested for #{@ticket.ticket_reference}"
        redirect_to(request.referrer || root_path)
      # end
    else
      flash[:warning] = "Something went wrong requesting feedback"
    end
  end

  def clear_feedback
    authorize @ticket
    user = User.where(:agent_id => @ticket.agent_id).first
    if @ticket.update(:feedback => false)
      if @current_user.agent_id != @ticket.agent_id
        @notify = Notification.new(:controller => "ticket", :item => "#{ @ticket.id }", :creator => "#{ @current_user.id }", :message => "has marked feedback complete on #{@ticket.ticket_reference}", :recipient => user.id)
        if @notify.save
          flash[:notice] = "Feedback marked complete for #{@ticket.ticket_reference}"
          redirect_to tickets_feedback_path
        else
          flash[:warning] = "Something went wrong marking feedback complete."
          redirect_to(request.referrer || root_path)
        end
      else
        redirect_to(request.referrer || root_path)
      end
    else
      flash[:warning] = "Something went wrong marking feedback complete."
      redirect_to(request.referrer || root_path)
    end
  end

  def delete
    @user = Agent.find(@ticket.agent_id)
    authorize @ticket
  end

  def destroy
    @user = Agent.find(@ticket.agent_id)
    authorize @ticket
    @ticket.qas.each do |d| d.destroy end
    @ticket.destroy
    flash[:notice] = "Ticket '#{@ticket.ticket_reference}' deleted successfully"
    redirect_to qa_path(@user.id, date_from: @date_from, date_to: @date_to)
  end

  private

  def set_user
    @user = Agent.find(params[:agent_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def get_setting
    @setting = Setting.where(:name => "qa_settings")
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
  end

  def set_dates
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
  end

  def ticket_params
    params.require(:ticket).permit(:ticket_reference, :date, :agent_id, :score, :notes, :feedback,
                                   :qas_attributes => [:qa_setting_id, :score, :out_of])
  end

end
