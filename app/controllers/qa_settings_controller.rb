class QaSettingsController < ApplicationController
  before_action :set_qa_setting, only: [:edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  def edit
    @teams = Team.sorted
    @position = QaSetting.count
    authorize QaSetting
  end

  def update
    authorize QaSetting
    @setting = Setting.where(:name => "qa_settings").first
    respond_to do |format|
      if @qa_setting.update(qa_setting_params)
        format.html { redirect_to setting_path(@setting.id), notice: 'Qa setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @qa_setting }
      else
        format.html { render :edit }
        format.json { render json: @qa_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize QaSetting
    @qa_setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_path, notice: 'QA setting was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qa_setting
      @qa_setting = QaSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qa_setting_params
      params.require(:qa_setting).permit(:name, :setting_id, :team_id, :description, :out_of, :qa, :position)
    end
end
