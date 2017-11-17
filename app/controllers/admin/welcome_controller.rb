class Admin::WelcomeController < Admin::ApplicationController
  def index
    @roasts = Roast.all
    @batches = Batch.all

    @count = 1
  end
end
