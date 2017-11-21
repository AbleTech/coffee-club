describe CreateVotingReport do

  let(:batches) { Batch.all.to_a }
  let(:votes) { Vote.all.to_a }

  before(:each) do
    @roast = Roast.create({ company: "People's", description: "Nice", name: "Coffee"})
    Batch.create({ start_date: "2017-08-15 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id})
    Vote.create({ rating: "good", date: "2017-08-16 00:00:00"})
    Vote.create({ rating: "good", date: "2017-08-16 00:00:00"})
    Vote.create({ rating: "bad", date: "2017-08-16 00:00:00"})
    Batch.create({ start_date: "2017-08-18 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast.id})
    Vote.create({ rating: "good", date: "2017-08-18 00:00:00"})
    Vote.create({ rating: "bad", date: "2017-08-18 00:00:00"})

    @roast2 = Roast.create({ company: "Mojo", description: "Coffee-ish", name: "Coffee 2"})
    Batch.create({ start_date: "2017-08-19 00:00:00", cost: 4.99, amount_purchased: 1, roast_id: @roast2.id})
    Vote.create({ rating: "good", date: "2017-08-19 00:01:00"})
    Vote.create({ rating: "bad", date: "2017-08-19 00:02:00"})
  end

  it 'correctly calculates number of votes' do
    report = CreateVotingReport.new(batches, votes).perform

    assert_equal report[@roast][:count], 5
    assert_equal report[@roast][:good], 3
    assert_equal report[@roast][:bad], 2

    assert_equal report[@roast2][:count], 2
    assert_equal report[@roast2][:good], 1
    assert_equal report[@roast2][:bad], 1
  end
end
