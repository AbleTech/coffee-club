class Admin::BatchesController < ApplicationController
  before_action :set_admin_batch, only: [:show, :edit, :update, :destroy]
  before_action :get_all_roasts

  def new
    @batch = Batch.new
    selected_roast = Roast.find_by_id(params[:roast])
    @batch.roast = selected_roast unless !selected_roast
  end

  def create
    @batch = Batch.new(admin_batch_params)
    if @batch.save
      redirect_to admin_roast_url(@batch.roast), notice: 'Batch was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @batch.update(admin_batch_params)
      redirect_to admin_roast_path(@batch.roast), notice: 'Batch was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    roast = @batch.roast
    @batch.destroy
    redirect_to admin_roast_url(roast), notice: 'Batch was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_batch
    @batch = Batch.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_batch_params
    params.require(:batch).permit(:roast_id, :start_date, :cost, :amount_purchased)
  end

  def get_all_roasts
    @roasts = Roast.all
  end

end
