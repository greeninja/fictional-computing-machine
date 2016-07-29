class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  def index
    @settings = Setting.sorted
  end

  def show
    @setting = Setting.find(params[:id])
    # TODO
    # This is UBER inificient - there has to be a better way!
    @tick_types = TickType.where(setting_id: params[:id])
    @rat_types = RatType.where(setting_id: params[:id])
  end

  def show_rat_types
    @rat_types = RatType.sorted
  end

  def show_tick_types
    @tick_types = TickType.sorted
  end

  def new
    @setting = Setting.new
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tick_types
    @setting = Setting.find(params[:id])
    @setting.tick_types.new
  end

  def rat_types
    @setting = Setting.find(params[:id])
    @setting.rat_types.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:name, :description, :enabled,
        :tick_types_attributes => [:name, :description, :setting_id],
        :rat_types_attributes => [:name, :description, :setting_id]
      )
    end
end
