class RatTypesController < ApplicationController
  before_action :set_rat_type, only: [:show, :edit, :update, :destroy]

  def index
    @rat_types = RatType.all
  end

  def show
  end

  def new
    @rat_type = RatType.new
  end

  def edit
  end

  def create
    @rat_type = RatType.new(rat_type_params)

    respond_to do |format|
      if @rat_type.save
        format.html { redirect_to @rat_type, notice: 'Rat type was successfully created.' }
        format.json { render :show, status: :created, location: @rat_type }
      else
        format.html { render :new }
        format.json { render json: @rat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rat_type.update(rat_type_params)
        format.html { redirect_to settings_path(params[:id => :setting_id]), notice: 'Rat type was successfully updated.' }
        format.json { render :show, status: :ok, location: @rat_type }
      else
        format.html { render :edit }
        format.json { render json: @rat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rat_type.destroy
    respond_to do |format|
      format.html { redirect_to rat_types_url, notice: 'Rat type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rat_type
      @rat_type = RatType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rat_type_params
      params.require(:rat_type).permit(:id, :setting_id, :name, :description)
    end
end
