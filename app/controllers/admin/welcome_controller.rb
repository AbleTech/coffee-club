class Admin::WelcomeController < Admin::ApplicationController
  def index
    @roasts = Roast.all
    @batches = Batch.all

    @count = 1

    @current_batch = Batch.order('start_date').last
  end
end
