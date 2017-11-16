class ApplicationController < ActionController::Base
  before_action :http_basic_authentication
  protect_from_forgery with: :exception

  def http_basic_authentication
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end
end
