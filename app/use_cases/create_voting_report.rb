class CreateVotingReport

  attr_reader :batches, :votes, :report

  def initialize(batches, votes)
    @batches = batches.sort_by{ |batch| batch.starts_at  }
    @votes = votes
    @report = {}
  end

  def perform
    batches.push(nil).each_cons(2) do |(current_batch, next_batch)|
      start_date = current_batch.starts_at.to_date
      end_date = next_batch ? next_batch.starts_at.prev_day.to_date : Date.current

      ratings_between_dates = votes.reduce([]) do |result, vote|
        if (start_date..end_date).include? vote.voted_at.to_date
          result << vote.rating.to_i
        end
        result
      end

      stats = {}
      stats[:count] = ratings_between_dates.count
      positive_votes, negative_votes = ratings_between_dates.partition { |rating| rating > 0 }
      stats[:good] = positive_votes.sum
      stats[:bad] = negative_votes.sum.abs
      stats[:score] = (stats[:good] - stats[:bad])

      update_report(current_batch.roast, stats)
    end
    report
  end

  private

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
