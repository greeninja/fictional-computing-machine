class RatsController < ApplicationController
  before_action :set_rat, only: [:show, :edit, :update, :destroy]

  before_filter :get_user

  def get_user
    @user = User.find(params[:user_id]) if params[:user_id]#
  end
  
  # GET /rats
  # GET /rats.json
  def index
    @rats = Rat.all
  end

  # GET /rats/1
  # GET /rats/1.json
  def show
  end

  # GET /rats/new
  def new
    @rat = Rat.new
  end

  # GET /rats/1/edit
  def edit
  end

  # POST /rats
  # POST /rats.json
  def create
    @rat = Rat.new(rat_params)

    respond_to do |format|
      if @rat.save
        format.html { redirect_to @rat, notice: 'Rat was successfully created.' }
        format.json { render :show, status: :created, location: @rat }
      else
        format.html { render :new }
        format.json { render json: @rat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rats/1
  # PATCH/PUT /rats/1.json
  def update
    respond_to do |format|
      if @rat.update(rat_params)
        format.html { redirect_to @rat, notice: 'Rat was successfully updated.' }
        format.json { render :show, status: :ok, location: @rat }
      else
        format.html { render :edit }
        format.json { render json: @rat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rats/1
  # DELETE /rats/1.json
  def destroy
    @rat.destroy
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: 'Rat was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rat
      @rat = Rat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rat_params
      params.fetch(:rat, {})
    end
end
