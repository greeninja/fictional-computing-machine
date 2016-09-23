class QaGeneralSettingsController < ApplicationController
  before_action :set_qa_setting
  before_action :confirm_logged_in
  after_action :verify_authorized

  def edit
    @teams = Team.sorted
    authorize QaGeneralSetting
  end

  def update
    authorize QaGeneralSetting
    @teams = Team.sorted
    @setting = Setting.where(:name => "qa_general_settings").first
    respond_to do |format|
      if @qa_general_setting.update(qa_general_setting_params)
        format.html { redirect_to setting_path(@setting.id), notice: 'Qa setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @qa_setting }
      else
        format.html { render :edit }
        format.json { render json: @qa_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize QaGeneralSetting
    @setting = Setting.where(:name => "qa_general_settings").first
    @qa_general_setting.destroy
    respond_to do |format|
      format.html { redirect_to setting_path(@setting.id), notice: 'QA setting was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qa_setting
      @qa_general_setting = QaGeneralSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qa_general_setting_params
      params.require(:qa_general_setting).permit(:name, :setting_id, :team_id, :value, :disabled)
    end
end
