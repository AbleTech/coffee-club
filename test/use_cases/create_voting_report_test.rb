require 'test_helper'

describe CreateVotingReport do

  let(:batches) { [] }
  let(:votes) { [] }

  before(:each) do
    @roast = Roast.new({ company: "People's", description: "Nice", name: "Coffee"})
    batches << Batch.new({ starts_at: "2017-08-15 00:00:00", cost: 4.99, amount_purchased: 1, roast: @roast})
    votes << Vote.new({ user_text: "good", rating: 1, voted_at: "2017-08-16 00:00:00"})
    votes << Vote.new({ user_text: "good", rating: 1, voted_at: "2017-08-16 00:00:00"})
    votes << Vote.new({ user_text: "bad", rating: -1, voted_at: "2017-08-16 00:00:00"})
    batches << Batch.new({ starts_at: "2017-08-18 00:00:00", cost: 4.99, amount_purchased: 1, roast: @roast})
    votes << Vote.new({ user_text: "good", rating: 1, voted_at: "2017-08-18 00:00:00"})
    votes << Vote.new({ user_text: "bad",  rating: -1, voted_at: "2017-08-18 00:00:00"})

    @roast2 = Roast.new({ company: "Mojo", description: "Coffee-ish", name: "Coffee 2"})
    batches << Batch.new({ starts_at: "2017-08-19 00:00:00", cost: 4.99, amount_purchased: 1, roast: @roast2})
    votes << Vote.new({ rating: "good", rating: 1, voted_at: "2017-08-19 00:00:00"})
    votes << Vote.new({ rating: "bad", rating: -1, voted_at: "2017-08-19 00:00:00"})
  end

  it 'correctly calculates number of votes' do
    report = CreateVotingReport.new(batches, votes).perform

    assert_equal report[@roast][:count], 5
    assert_equal report[@roast][:good], 3
    assert_equal report[@roast][:bad], 2
    assert_equal report[@roast][:score], 1

    assert_equal report[@roast2][:count], 2
    assert_equal report[@roast2][:good], 1
    assert_equal report[@roast2][:bad], 1
    assert_equal report[@roast2][:score], 0
  end
end
