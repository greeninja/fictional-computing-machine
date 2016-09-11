class TicketsController < ApplicationController

  before_action :set_user, only: [:show, :edit, :new, :destroy, :qa]
  before_action :set_ticket, only: [:qa, :update]
  before_action :get_setting, only: [:show, :new, :qa]

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
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

  def update
    @user = Agent.find(@ticket.agent_id)
    if @ticket.update(ticket_params)
    # If update succeeds, redirect to the index action
      flash[:notice] = "QA for #{ @ticket_id } created successfully"
      redirect_to(:controller => "qas", :action => 'show', :id => @user.id)
    else
    # If update fails, redisplay the form so user can fix problems
      @ticket = Ticket.find(params[:id])
      @user = Agent.find(@ticket.agent_id)
      render 'edit', ticket: @ticket
    end

  end


  def delete
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
