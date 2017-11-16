class WelcomeController < ApplicationController
  skip_before_action :http_basic_authentication
  def index
  end
end
