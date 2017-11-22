class Admin::WelcomeController < Admin::ApplicationController
  require_relative '../welcome_controller'
  def index
    batches = Batch.preload(:roast).order("starts_at asc").to_a
    votes = Vote.all.to_a

    report = CreateVotingReport.new(batches, votes).perform

    @active_batch = Batch.active_batch(batches)
    @active_roast = @active_batch.roast

    @active_roast_scores = {:good => report[@active_roast][:good], :bad => report[@active_roast][:bad]}

    @sorted_report = report.sort_by { |_, stats| stats[:score] }.reverse[0..9]
    @top_10_batches = batches[0..9]
  end
end
