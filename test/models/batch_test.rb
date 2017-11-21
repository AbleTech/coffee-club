require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  setup do
    @roast = roasts(:roast1)
    @valid_params = {:start_date => Date.today, :amount_purchased => 22, :cost => 4.5, :roast => @roast}
    @batch = Batch.new(@valid_params)
  end

  test 'is valid' do
    assert @batch.valid?
  end

  [:start_date, :amount_purchased, :cost, :roast_id].each do |param|
    test "#{param} is required" do
      @batch[param] = nil

      assert @batch.invalid?
    end
  end

  test 'start_date is allowed to be today' do
    @batch.start_date = Date.today

    assert @batch.valid?
  end

  test 'start_date must be earlier than today' do
    @batch.start_date = 5.days.ago

    assert @batch.valid?
  end

  test 'start_date cannot be after today' do
    @batch.start_date = 5.days.from_now

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

  test 'cannot add two batches with the same start_date' do
    @batch.start_date = Date.today
    @batch.save

    assert @batch.valid?

    batch2 = Batch.new(@valid_params)
    batch2.start_date = Date.today

    assert batch2.invalid?
  end
end
