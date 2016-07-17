class TicksController < ApplicationController
  before_action :set_tick, only: [:show, :edit, :update, :destroy]

  # GET /ticks
  # GET /ticks.json
  def index
    @ticks = Tick.all
  end

  # GET /ticks/1
  # GET /ticks/1.json
  def show
  end

  # GET /ticks/new
  def new
    @tick = Tick.new
  end

  # GET /ticks/1/edit
  def edit
  end

  # POST /ticks
  # POST /ticks.json
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

  # PATCH/PUT /ticks/1
  # PATCH/PUT /ticks/1.json
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

  # DELETE /ticks/1
  # DELETE /ticks/1.json
  def destroy
    @tick.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Tick was successfully destroyed.' }
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
