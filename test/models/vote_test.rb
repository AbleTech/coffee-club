require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  setup do
    @valid_params = {:date => Date.today.beginning_of_day, :rating => "good"}
    @vote = Vote.new(@valid_params)
  end

  test 'is valid' do
    assert @vote.valid?
  end

  [:date, :rating].each do |param|
    test "#{param} is required" do
      @vote[param] = nil

      assert @vote.invalid?
    end
  end

  test 'is valid rating - good' do
    @vote.rating = "good"

    assert @vote.valid?
  end

  test 'is valid rating - bad' do
    @vote.rating = "bad"

    assert @vote.valid?
  end

  test 'is invalid rating' do
    @vote.rating = "badasda"

    assert @vote.invalid?
  end

  test 'is invalid rating - nil' do
    @vote.rating = nil

    assert @vote.invalid?
  end
end
