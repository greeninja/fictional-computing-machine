class TicksController < ApplicationController
  before_action :set_tick, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in

  def index
    @ticks = Tick.all
  end

  def show
  end

  def new
    @tick = Tick.new
  end

  def edit
  end

  def create
    @tick = Tick.new(tick_params)

    respond_to do |format|
      if @tick.save
        format.html { redirect_to @tick, notice: 'Tick was successfully created.' }
        format.json { render :show, status: :created, location: @tick }
      else
        format.html { render :new }
        format.json { render json: @tick.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tick.update(tick_params)
        format.html { redirect_to @tick, notice: 'Tick was successfully updated.' }
        format.json { render :show, status: :ok, location: @tick }
      else
        format.html { render :edit }
        format.json { render json: @tick.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tick.destroy
    @user = Agent.find(params[:agent_id])
    respond_to do |format|
      format.html { redirect_to agent_path(@user), notice: 'Tick was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tick
      @tick = Tick.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tick_params
      params.fetch(:tick, {})
    end
end
