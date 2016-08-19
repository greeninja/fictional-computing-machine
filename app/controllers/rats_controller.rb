class RatsController < ApplicationController
  before_action :set_rat, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  before_filter :get_user

  def get_user
    @user = Agent.find(params[:agent_id]) if params[:agent_id]
  end

  def index
    @rats = Rat.all
    authorize Rat
  end

  def show
    authorize Rat
  end

  def new
    @rat = Rat.new
    authorize Rat
  end

  def edit
    authorize Rat
  end

  def create
    @rat = Rat.new(rat_params)
    authorize Rat

    respond_to do |format|
      if @rat.save
        format.html { redirect_to @rat, notice: 'Rat was successfully created.' }
        format.json { render :show, status: :created, location: @rat }
      else
        format.html { render :new }
        format.json { render json: @rat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Rat
    respond_to do |format|
      if @rat.update(rat_params)
        format.html { redirect_to @rat, notice: 'Rat was successfully updated.' }
        format.json { render :show, status: :ok, location: @rat }
      else
        format.html { render :edit }
        format.json { render json: @rat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize Rat
    @rat.destroy
    @user = Agent.find(params[:agent_id])
    respond_to do |format|
      format.html { redirect_to agent_path(@user), notice: 'Rat was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rat
      @rat = Rat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rat_params
      params.fetch(:rat, {})
    end
end
