class CreateVotingReport

  attr_reader :batches, :votes, :report

  def initialize(batches, votes)
    @batches = batches
    @votes = votes
    @report = {}
  end

  def perform
    batches.each do |batch|
      date_before_next_batch = find_date_before_next_batch(batch)


      all_votes_between_dates = votes.select do |vote|
        vote.voted_at >= batch.starts_at && vote.voted_at <= date_before_next_batch
      end

      stats = {}
      stats[:count] = all_votes_between_dates.count
      stats[:good] = all_votes_between_dates.select { |vote| vote.rating == 1 }.count
      stats[:bad] = all_votes_between_dates.select { |vote| vote.rating == -1 }.count
      stats[:score] = all_votes_between_dates.sum { |vote| vote.rating }

      update_report(batch.roast, stats)
    end
    report
  end

  private

  def find_date_before_next_batch(batch)
    next_batch_starts_at =
    if batch == batches.last
      Date.today.beginning_of_day
    else
      batches[batches.find_index(batch) + 1].starts_at.prev_day
    end
  end

  def update_report(roast, stats)
    if report.key?(roast)
      report[roast][:count] += stats[:count]
      report[roast][:good] += stats[:good]
      report[roast][:bad] += stats[:bad]
      report[roast][:score] += stats[:score]
    else
      report[roast] ||= stats
    end
  end
end
