class SendSlackNotification
  attr_reader :response_url, :response, :uri, :http, :req

  def initialize(response_url, response)
    @response_url = response_url
    @response = response
    @uri = URI(response_url)
    @http = Net::HTTP.new(uri.host, uri.port)
    @req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
  end

  def perform
    req.body = { "text" => response }.to_json
    http.request(req)
  end
end
