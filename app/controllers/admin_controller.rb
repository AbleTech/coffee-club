class AdminController < ApplicationController
  def index
    @roasts = Roast.all
    @batches = Batch.all
  end
end
