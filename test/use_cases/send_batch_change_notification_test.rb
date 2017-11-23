require 'test_helper'
require 'net/http'

describe SendBatchChangeNotification do
  let(:roast){ Roast.new({ company: "People's", description: "Nice", name: "Coffee"}) }
  let(:batch){ Batch.new({ starts_at: Date.today, cost: 4.99, amount_purchased: 1, roast: roast}) }
  let(:url){ "https://test.website.not.real" }
  let(:uri){ URI(url) }
  let(:slack_message){ ":coffee: A new batch of coffee is available in the kitchen! :coffee:"\
    "\nThe new roast is *#{batch.roast.company} #{batch.roast.name}*."\
    "\nTo view the votes, <https://coffee-club-app.herokuapp.com/|click here>."\
    "\nUse `/coffee good` to upvote the roast"\
    "\nUse `/coffee bad` to downvote the roast." }

  it 'sends a notification when a batch is added today' do
    http_mock = Minitest::Mock.new
    post_mock = Minitest::Mock.new
    http_mock.expect(:request, true, [post_mock])
    http_mock.expect(:use_ssl=, true, [true])
    post_mock.expect(:body=, true, [{ "text" => slack_message }.to_json])
    Net::HTTP.stub(:new, http_mock, [uri.host, uri.port]) do
      Net::HTTP::Post.stub(:new, post_mock, [uri.path, {'Content-Type' =>'application/json'}]) do
        SendBatchChangeNotification.new(batch, url).perform
      end
    end
    assert http_mock.verify
    assert post_mock.verify
  end
end
