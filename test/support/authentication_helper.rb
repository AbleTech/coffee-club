class Request
  attr_reader :type, :url

  def initialize(type, url)
    @type = type
    @url = url
  end

  def params
    case type
    when :post, :patch
      {params: {}}
    end
  end

  def method_params
    [type, url, params].compact
  end
end

def check_for_authentication(requests)
  requests.each do |request|
    send(*request.method_params)
    assert_response 401
  end
end
