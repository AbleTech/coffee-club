require 'net/http'

class SendBatchChangeNotification
  attr_reader :batch, :uri, :http, :req

  def initialize(batch, url)
    @batch = batch
    @uri = URI(url)
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
  end

  def perform
    if starts_at_is_today(batch.starts_at)
      req.body = { "text" => ":coffee: A new batch of coffee is available in the kitchen! :coffee:"\
        "\nThe new roast is *#{batch.roast.company} #{batch.roast.name}*."\
        "\nTo view the votes, <https://coffee-club-app.herokuapp.com/|click here>."\
        "\nUse `/coffee good` to upvote the roast"\
        "\nUse `/coffee bad` to downvote the roast."}.to_json
      http.request(req)
    end
  end

  private

  def starts_at_is_today(starts_at)
    starts_at == Date.current.beginning_of_day
  end
end
