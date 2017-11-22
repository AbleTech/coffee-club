class VotesController < WelcomeController
  def create
    @vote = Vote.new
    @vote.date = Date.today.beginning_of_day
    @vote.rating = vote_params[:text].downcase

    response = if @vote.save
      "Successfully voted #{@vote.rating}"
    else
      "Error processing vote - the valid keywords are good and bad"
    end
    render json: response

    SendSlackNotification.new(vote_params[:response_url], response).perform
  end

  private

  def vote_params
    params.permit(:user_name, :text, :response_url)
  end
end
