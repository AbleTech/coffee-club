module ApplicationHelper

  def format_roast_options(roasts)
    roasts.collect{|r| ["#{r.company} #{r.name}", r.id]}
  end
end
