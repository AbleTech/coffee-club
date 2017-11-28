require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  setup do
    @roast = roasts(:roast1)
    @valid_params = {:starts_at => Date.today, :amount_purchased => 22, :cost => 4.5, :roast => @roast}
    @batch = Batch.new(@valid_params)
  end

  test 'is valid' do
    assert @batch.valid?
  end

  [:starts_at, :amount_purchased, :cost, :roast_id].each do |param|
    test "#{param} is required" do
      @batch[param] = nil

      assert @batch.invalid?
    end
  end

  test 'starts_at is allowed to be today' do
    @batch.starts_at = Date.today

    assert @batch.valid?
  end

  test 'starts_at must be earlier than today' do
    @batch.starts_at = 5.days.ago

    assert @batch.valid?
  end

  test 'starts_at cannot be after today' do
    @batch.starts_at = 5.days.from_now

    assert @batch.invalid?
  end

  test 'amount_purchased cannot be negative' do
    @batch.amount_purchased = -45

    assert @batch.invalid?
  end

  test 'cost cannot be negative' do
    @batch.cost = -55

    assert @batch.invalid?
  end

  test 'cost can be $0' do
    @batch.cost = 0

    assert @batch.valid?
  end

  test 'cannot add two batches with the same starts_at' do
    @batch.starts_at = Date.today
    @batch.save

    assert @batch.valid?

    batch2 = Batch.new(@valid_params)
    batch2.starts_at = Date.today

    assert batch2.invalid?
  end
end
