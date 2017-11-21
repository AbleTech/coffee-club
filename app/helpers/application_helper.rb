module ApplicationHelper
  def format_roast_options(roasts)
    roasts.collect{|r| ["#{r.company} #{r.name}", r.id]}
  end

  def calculate_score(stats)
    stats[:good] - stats[:bad]
  end

  def sort_report(report)
    report.sort_by do |roast, stats|
      calculate_score(stats[:good], stats[:bad])
    end
  end

  def good_score(roast)
    roast[:roast][:good]
  end
end
