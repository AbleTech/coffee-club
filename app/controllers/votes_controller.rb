class VotesController < WelcomeController
  skip_before_action :verify_authenticity_token

  def create
    @vote = Vote.new({
      voted_at: Date.current.in_time_zone.beginning_of_day,
      user_text: vote_params[:text].downcase,
      rating: calculate_rating(vote_params[:text].downcase)
    })

    response = if @vote.save
      "Successfully #{@vote.rating == 1 ? "upvoted" : "downvoted"} the batch"
    else
      "Error processing vote - the valid keywords are good (+1) and bad (-1)"
    end
    render json: response

    SendSlackNotification.new(vote_params[:response_url], response).perform
  end

  private

  def vote_params
    params.permit(:user_name, :text, :response_url)
  end

  def calculate_rating(user_text)
    (user_text == "good" || user_text == "+1") ? 1 : -1
  end
end
