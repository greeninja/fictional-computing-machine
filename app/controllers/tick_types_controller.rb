class TickTypesController < ApplicationController
  before_action :set_tick_type, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    @tick_types = TickType.all
    authorize TickType
  end

  def show
    authorize TickType
  end

  def new
    @tick_type = TickType.new
    authorize TickType
  end

  # GET /tick_types/1/edit
  def edit
    @tick_type = TickType.find(params[:id])
    authorize TickType
  end

  def create
    @tick_type = TickType.new(tick_type_params)
    authorize TickType

    respond_to do |format|
      if @tick_type.save
        format.html { redirect_to @tick_type, notice: 'Tick type was successfully created.' }
        format.json { render :show, status: :created, location: @tick_type }
      else
        format.html { render :new }
        format.json { render json: @tick_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize TickType
    respond_to do |format|
      if @tick_type.update(tick_type_params)
        format.html { redirect_to settings_path(params[:id => :setting_id]), notice: 'Tick type was successfully updated.' }
        # format.json { render :show, status: :ok, location: @tick_type }
      else
        format.html { render :edit }
        format.json { render json: @tick_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize TickType
    @tick_type.destroy
    respond_to do |format|
      format.html { redirect_to settings_path, notice: 'Tick type was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tick_type
      @tick_type = TickType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tick_type_params
      params.require(:tick_type).permit(:id, :name, :setting_id, :description)
    end
end
