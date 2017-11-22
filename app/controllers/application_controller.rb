class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def calculate_stats
    batches = Batch.preload(:roast).all.to_a
    votes = Vote.all.to_a

    report = CreateVotingReport.new(batches, votes).perform

    current_roast = DetermineCurrentRoast.new(batches).perform

    @sorted_report = report.sort_by { |roast, stats| stats[:good] - stats[:bad] }.reverse[0..9]
    @top_10_batches = batches.sort_by { |batch| batch.start_date }.reverse[0..9]
    @current_roast = {
      :company => current_roast[:roast][:company],
      :name => current_roast[:roast][:name],
      :start_date => current_roast[:start_date],
      :good => report[current_roast[:roast]][:good],
      :bad => report[current_roast[:roast]][:bad],
      :desc => current_roast[:roast][:description]
    }
  end
end
