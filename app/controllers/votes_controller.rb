require 'net/http'

class VotesController < WelcomeController
  skip_before_action :verify_authenticity_token

  def create
    vote_params
    @vote = Vote.new
    @vote.date = Date.today.beginning_of_day
    @vote.rating = params[:text].downcase

    response = if @vote.save
      "Successfully voted #{@vote.rating}"
    else
      "Error processing vote"
    end
    render json: response

    send_response_to_slack(response, URI(params[:response_url]))
  end

  private

  def vote_params
    params.require([:user_name, :text, :response_url])
  end

  def send_response_to_slack(message, uri)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    req.body = { "text" => message }.to_json
    res = http.request(req)
  end
end
