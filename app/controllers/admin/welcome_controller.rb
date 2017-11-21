class Admin::WelcomeController < Admin::ApplicationController
  def index
    @batches = Batch.preload(:roast).all
    @votes = Vote.all

    @report = CreateVotingReport.new(@batches, @votes).perform

    @current_roast = DetermineCurrentRoast.new(@batches).perform
  end
end
