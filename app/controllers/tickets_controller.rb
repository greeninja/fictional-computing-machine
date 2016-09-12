class TicketsController < ApplicationController

  before_action :set_user, only: [:show, :new, :qa]
  before_action :set_ticket, only: [:edit, :qa, :update, :delete, :destroy]
  before_action :get_setting, only: [:show, :new, :qa]

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @user = Agent.find(@ticket.agent_id)
    if @ticket.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "Ticket '#{@ticket.ticket_reference}' successfully added"
      redirect_to(:action => "qa", :id => @ticket.id, agent_id: @ticket.agent_id)
    else
    # If save fails, redisplay the form so user can fix problems
      render 'new', ticket: @ticket
    end
  end

  def qa
    @ticket.qas.new
  end

  def edit
    @user = Agent.find(@ticket.agent_id)
  end

  def update
    @user = Agent.find(@ticket.agent_id)
    @qa_settings = QaSetting.where("qa_settings.team_id = #{@user.team_id}").or(QaSetting.where("qa_settings.team_id is null")).sorted
    if @ticket.update(ticket_params)
    # Update score total
      score = @ticket.qas.sum(:score)
      total_available = @qa_settings.sum(:out_of)
      total_score = (score.to_f / total_available.to_f) * 100
      update_score = @ticket.update(:score => total_score)
    # If update succeeds, redirect to the index action
      flash[:notice] = "QA for #{ @ticket.ticket_reference } created successfully"
      redirect_to(:controller => "qas", :action => 'show', :id => @user.id)
    else
    # If update fails, redisplay the form so user can fix problems
      @ticket = Ticket.find(params[:id])
      @user = Agent.find(@ticket.agent_id)
      flash[:warning] = "All QA Items need to be filled out"
      render 'qa', ticket: @ticket
    end

  end

  def delete
  end

  def destroy
    @user = Agent.find(@ticket.agent_id)
    @ticket.qas.each do |d| d.destroy end
    @ticket.destroy
    flash[:notice] = "Ticket '#{@ticket.ticket_reference}' deleted successfully"
    redirect_to qa_path(@user.id), agent_id: @ticket.agent_id
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

  def ticket_params
    params.require(:ticket).permit(:ticket_reference, :date, :agent_id, :score, :notes,
                                   :qas_attributes => [:qa_setting_id, :score, :out_of])
  end

end
