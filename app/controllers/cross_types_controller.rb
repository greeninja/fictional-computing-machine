class CrossTypesController < ApplicationController
  before_action :set_cross_type, only: [:edit, :update, :destroy]
  before_action :confirm_logged_in
  after_action :verify_authorized

  def edit
    authorize CrossType
  end

  def update
    authorize CrossType
    respond_to do |format|
      if @cross_type.update(cross_type_params)
        format.html { redirect_to settings_path(params[:id => :setting_id]), notice: 'Cross type was successfully updated.' }
        format.json { render :show, status: :ok, location: @cross_type }
      else
        format.html { render :edit }
        format.json { render json: @cross_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize CrossType
    @cross_type.destroy
    respond_to do |format|
      format.html { redirect_to settings_path, notice: 'Cross type was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cross_type
      @cross_type = CrossType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cross_type_params
      params.require(:cross_type).permit(:id, :setting_id, :name, :description)
    end
end
