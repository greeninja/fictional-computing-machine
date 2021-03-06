class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy, :tick_types, :cross_types, :qa_settings, :qa_general_settings]
  before_action :confirm_logged_in
  after_action :verify_authorized

  def index
    authorize Setting
    @settings = Setting.sorted
  end

  def show
    authorize Setting
    @setting = Setting.find(params[:id])
    # TODO
    # This is UBER inificient - there has to be a better way!
    @tick_types = TickType.where(setting_id: params[:id])
    @cross_types = CrossType.where(setting_id: params[:id])
    @qa_settings = QaSetting.all
    @teams = Team.sorted
  end

  def show_cross_types
    authorize Setting
    @cross_types = CrossType.sorted
  end

  def show_tick_types
    authorize Setting
    @tick_types = TickType.sorted
  end

  def new
    authorize Setting
    @setting = Setting.new
  end

  def edit
    authorize Setting
  end

  def create
    @setting = Setting.new(setting_params)
    authorize Setting

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
    authorize Setting
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
    authorize Setting
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def tick_types
    @setting.tick_types.new
    authorize Setting
  end

  def cross_types
    @setting.cross_types.new
    authorize Setting
  end

  def qa_settings
    @setting.qa_settings.new
    @teams = Team.sorted
    @position = QaSetting.count + 1
    authorize Setting
  end

  def qa_general_settings
    @teams = Team.sorted
    @setting.qa_general_settings.new
    authorize Setting
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
        :cross_types_attributes => [:name, :description, :setting_id],
        :qa_settings_attributes => [:name, :setting_id, :team_id, :description, :out_of, :qa, :position],
        :qa_general_settings_attributes => [:name, :value, :team_id, :disabled]
      )
    end
end
