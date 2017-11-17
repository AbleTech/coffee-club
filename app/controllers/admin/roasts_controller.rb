class Admin::RoastsController < Admin::ApplicationController
  before_action :set_admin_roast, only: [:show, :edit, :update, :destroy]

  # GET /admin/roasts
  def index
    @roasts = Roast.includes(:batches).all
  end

  # GET /admin/roasts/new
  def new
    @roast = Roast.new
  end

  # GET /admin/roasts/1/edit
  def edit
  end

  # POST /admin/roasts
  def create
    @roast = Roast.new(admin_roast_params)
    if @roast.save
      redirect_to admin_roasts_path, notice: 'Roast was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/roasts/1
  def update
    if @roast.update(admin_roast_params)
      redirect_to admin_roasts_path, notice: 'Roast was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/roasts/1
  def destroy
    @roast.destroy
    redirect_to admin_roasts_url, notice: 'Roast was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_roast
      @roast = Roast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_roast_params
      params.require(:roast).permit(:company, :name, :description)
    end
end
