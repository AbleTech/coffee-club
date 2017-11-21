module AdminHelper
  def calculate_score(stats)
    stats[:good] - stats[:bad]
  end
end
