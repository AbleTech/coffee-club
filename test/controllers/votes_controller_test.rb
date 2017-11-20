require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_params = {
      :token => 'ojd8ot4hqj587wsrwn8I7OwZ',
      :team_id => 'T024FPB26',
      :team_domain => 'abletech',
      :channel_id => 'D803S23L7',
      :channel_name => 'directmessage',
      :user_id => 'U7U9DT2FN',
      :user_name => 'matthew.lee',
      :command => '/coffee-dev',
      :text => 'good',
      :response_url => 'https://hooks.slack.com/commands/T024FPB26/274762255539/pIqxQRRaKU0DQovhIBSDuLyH',
      :trigger_id => '274179789904.2151793074.7d44173301ffc568b42520311e7b5e37'
    }

  end

  test 'good vote is recorded' do
    @post_params[:text] = 'good'
    assert_difference('Vote.count') do
      post votes_url, params: @post_params
    end

    assert_equal response.body, "Successfully voted good"
  end

  test 'bad vote is recorded' do
    @post_params[:text] = 'bad'
    assert_difference('Vote.count') do
      post votes_url, params: @post_params
    end

    assert_equal response.body, "Successfully voted bad"
  end

  test 'invalid vote is recorded' do
    @post_params[:text] = 'not good or bad but ok'
    assert_no_difference('Vote.count') do
      post votes_url, params: @post_params
    end

    assert_equal response.body, "Error processing vote - the valid keywords are good and bad"
  end

  test 'send notification to Slack' do
    mock = Minitest::Mock.new
    mock.expect(:perform, true)

    check_send = lambda { |response_url, response|
      assert_equal response_url, "https://hooks.slack.com/commands/T024FPB26/274762255539/pIqxQRRaKU0DQovhIBSDuLyH"
      assert_equal response, "Successfully voted good"
      mock
    }

    SendSlackNotification.stub(:new, check_send, [@post_params[:response_url], "Successfully voted good"]) do
      post votes_url, params: @post_params
    end

    assert mock.verify
  end
end
