class Admin::WelcomeController < Admin::ApplicationController
  def index
    @roasts = Roast.all
    @batches = Batch.all
  end
end
