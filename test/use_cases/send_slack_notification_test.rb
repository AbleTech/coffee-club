require 'test_helper'

describe SendSlackNotification do
  let(:response_url){ "https://hooks.slack.com/commands/T024FPB26/274762255539/pIqxQRRaKU0DQovhIBSDuLyH" }
  let(:response){ "Successfully voted good" }
  let(:uri){ URI(response_url) }

  it 'performs HTTP request' do
    http_mock = Minitest::Mock.new
    post_mock = Minitest::Mock.new
    http_mock.expect(:request, true, [post_mock])
    post_mock.expect(:body=, true, [{ "text" => response }.to_json])

    Net::HTTP.stub(:new, http_mock, [uri.host, uri.port]) do
      Net::HTTP::Post.stub(:new, post_mock, [uri.path, {'Content-Type' =>'application/json'}]) do
        SendSlackNotification.new(response_url, response).perform
      end
    end
    assert http_mock.verify
    assert post_mock.verify
  end
end
