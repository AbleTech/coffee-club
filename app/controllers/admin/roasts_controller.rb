class Admin::RoastsController < ApplicationController
  before_action :set_admin_roast, only: [:show, :edit, :update, :destroy]

  # GET /admin/roasts
  # GET /admin/roasts.json
  def index
    @admin_roasts = Admin::Roast.all
  end

  # GET /admin/roasts/1
  # GET /admin/roasts/1.json
  def show
  end

  # GET /admin/roasts/new
  def new
    @admin_roast = Admin::Roast.new
  end

  # GET /admin/roasts/1/edit
  def edit
  end

  # POST /admin/roasts
  # POST /admin/roasts.json
  def create
    @admin_roast = Admin::Roast.new(admin_roast_params)

    respond_to do |format|
      if @admin_roast.save
        format.html { redirect_to @admin_roast, notice: 'Roast was successfully created.' }
        format.json { render :show, status: :created, location: @admin_roast }
      else
        format.html { render :new }
        format.json { render json: @admin_roast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/roasts/1
  # PATCH/PUT /admin/roasts/1.json
  def update
    respond_to do |format|
      if @admin_roast.update(admin_roast_params)
        format.html { redirect_to @admin_roast, notice: 'Roast was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_roast }
      else
        format.html { render :edit }
        format.json { render json: @admin_roast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/roasts/1
  # DELETE /admin/roasts/1.json
  def destroy
    @admin_roast.destroy
    respond_to do |format|
      format.html { redirect_to admin_roasts_url, notice: 'Roast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_roast
      @admin_roast = Admin::Roast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_roast_params
      params.require(:admin_roast).permit(:company, :roastName, :description)
    end
end
