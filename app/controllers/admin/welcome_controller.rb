class Admin::WelcomeController < Admin::ApplicationController
  def index
    batches = Batch.preload(:roast).order("starts_at asc").to_a
    votes = Vote.all.to_a

    report = CreateVotingReport.new(batches, votes).perform

    current_roast = Roast.active_roast(batches)

    @sorted_report = report.sort_by { |_, stats| stats[:score] }.reverse[0..9]
    @top_10_batches = batches[0..9]
    @current_roast = {
      :company => current_roast[:roast][:company],
      :name => current_roast[:roast][:name],
      :starts_at => current_roast[:starts_at],
      :good => report[current_roast[:roast]][:good],
      :bad => report[current_roast[:roast]][:bad]
    }
  end
end
