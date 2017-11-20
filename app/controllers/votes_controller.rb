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
      "Error processing vote - the valid keywords are good and bad"
    end
    render json: response

    SendSlackNotification.new(params[:response_url], response).perform
  end

  private

  def vote_params
    params.require([:user_name, :text, :response_url])
  end
end
