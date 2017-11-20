class SendSlackNotification
  include UseCasePattern

  attr_reader :res

  def initialize(response_url, response)
    @response_url = response_url
    @response = response
  end

  def perform
    uri = URI(@response_url)
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    req.body = { "text" => @response }.to_json
    @res = http.request(req)
  end
end
