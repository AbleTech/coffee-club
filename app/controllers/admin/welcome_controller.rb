class Admin::WelcomeController < Admin::ApplicationController
  def index
    batches = Batch.preload(:roast).order("starts_at desc")
    stats_for_roast_report = CreateVotingReport.new(batches, Vote.all).perform

    @active_batch = batches.active

    if @active_batch.present?
      @active_roast = @active_batch.roast
      @active_roast_scores = stats_for_roast_report[@active_roast]
      @sorted_report = stats_for_roast_report.sort_by { |_, stats| stats[:score] }.reverse[0..9]
      @top_10_batches = batches.first(10)
    end
  end
end
