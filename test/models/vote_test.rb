require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  setup do
    @valid_params = {:voted_at => DateTime.now, :user_text => "good", :rating => 1}
    @vote = Vote.new(@valid_params)
  end

  test 'is valid' do
    assert @vote.valid?
  end

  [:voted_at, :user_text, :rating].each do |param|
    test "#{param} is required" do
      @vote[param] = nil

      assert @vote.invalid?
    end
  end

  ["good", "bad", "+1", "-1"].each do |text|
    test "#{text} rating is valid" do
      @vote.user_text = text

      assert @vote.valid?
    end
  end

  test 'is invalid user_text' do
    @vote.user_text = "badasda"

    assert @vote.invalid?
  end

  test 'is invalid user_text - nil' do
    @vote.user_text = nil

    assert @vote.invalid?
  end
end
