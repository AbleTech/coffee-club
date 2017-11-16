class Admin::BatchesController < ApplicationController
  #before_action :set_admin_batch, only: [:show, :edit, :update, :destroy]

  def new
    @batch = Batch.new
    @roast = Roast.find(params[:roast])
    @batch.roast = Roast.find(params[:roast])
  end

  def create
    @batch = Batch.new(admin_batch_params)
    if @batch.save
      redirect_to admin_roast_url(@batch.roast_id), notice: 'Batch was successfully created.'
    else
      render :new
    end
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

end
