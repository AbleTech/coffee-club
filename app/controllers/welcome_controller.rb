class WelcomeController < ApplicationController
  def index
    calculate_stats
  end
end
