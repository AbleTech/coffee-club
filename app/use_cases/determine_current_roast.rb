class DetermineCurrentRoast

  attr_reader :batches

  def initialize(batches)
    @batches = batches
  end

  def perform
    batches.sort_by! &:start_date
    current_batch = batches.last
    {:roast => current_batch.roast, :start_date => current_batch.start_date}
  end
end
