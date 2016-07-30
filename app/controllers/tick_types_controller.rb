class TickTypesController < ApplicationController
  before_action :set_tick_type, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in

  def index
    @tick_types = TickType.all
  end

  def show
  end

  def new
    @tick_type = TickType.new
  end

  # GET /tick_types/1/edit
  def edit
    @tick_type = TickType.find(params[:id])
  end

  def create
    @tick_type = TickType.new(tick_type_params)

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
    @tick_type.destroy
    respond_to do |format|
      format.html { redirect_to tick_types_url, notice: 'Tick type was successfully destroyed.' }
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
