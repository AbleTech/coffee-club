class WelcomeController < ApplicationController
  def index
    batches = Batch.preload(:roast)
    report = CreateVotingReport.new(batches, Vote.all).perform

    @active_batch = batches.active

    if !@active_batch.blank?
      @active_roast = @active_batch.roast
      @active_roast_scores = {:good => report[@active_roast][:good], :bad => report[@active_roast][:bad]}
      @sorted_report = report.sort_by { |_, stats| stats[:score] }.reverse[0..9]
    end
  end
end
