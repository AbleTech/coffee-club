class CreateVotingReport

  attr_reader :batches, :votes, :report

  def initialize(batches, votes)
    @batches = batches
    @votes = votes
    @report = {}
  end

  def perform
    batches.sort_by! &:start_date
    batches.each do |batch|
      date_before_next_batch = find_date_before_next_batch(batch)

      all_votes_between_dates = votes.select do |vote|
        vote.date >= batch.start_date && vote.date <= date_before_next_batch
      end

      stats = {}
      stats[:count] = all_votes_between_dates.count
      stats[:good] = all_votes_between_dates.select { |vote| vote.rating == "good" }.count
      stats[:bad] = all_votes_between_dates.select { |vote| vote.rating == "bad" }.count

      update_report(batch.roast, stats)
    end
    report
  end

  private

  def find_date_before_next_batch(batch)
    next_batch_start_date =
    if batch == batches.last
      Date.today.beginning_of_day
    else
      batches[batches.find_index(batch) + 1].start_date.prev_day
    end
  end

  def update_report(roast, stats)
    if report.key?(roast)
      report[roast][:count] += stats[:count]
      report[roast][:good] += stats[:good]
      report[roast][:bad] += stats[:bad]
    else
      report[roast] ||= stats
    end
  end
end
