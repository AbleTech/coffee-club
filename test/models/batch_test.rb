require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  setup do
    @roast = roasts(:roast1)
    @valid_params = {:starts_at => Date.today, :amount_purchased => 22, :cost => 4.5, :roast => @roast}
    @batch = Batch.new(@valid_params)
  end

  teardown do
    travel_back
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

  test 'starts_at is allowed to be today when current time is 12AM' do
    travel_to Time.zone.local(2016,12,27,00,00,00)
    @batch.starts_at = "2016-12-27"
    assert @batch.valid?
  end

  test 'starts_at is allowed to be today when current time is 1PM' do
    travel_to Time.zone.local(2016,12,27,13,00,00)
    @batch.starts_at = "2016-12-27"
    assert @batch.valid?
  end

  test 'starts_at is allowed to be today when current time is 11.59PM' do
    travel_to Time.zone.local(2016,12,27,23,59,00)
    @batch.starts_at = "2016-12-27"
    assert @batch.valid?
  end

  test 'starts_at cannot be tomorrow when time is 11:59PM' do
    travel_to Time.zone.local(2016,12,27,23,59,00)
    @batch.starts_at = "2016-12-28"
    assert @batch.invalid?
  end

  test 'starts_at cannot be tomorrow when time is 00:00AM' do
    travel_to Time.zone.local(2016,12,27,00,00,00)
    @batch.starts_at = "2016-12-28"
    assert @batch.invalid?
  end

  test 'batch is valid when it is yesterday after 11AM UTC' do
    travel_to Time.utc(2016,12,27,22,00,00) # 10PM UTC, 11AM Wellington the next day
    @batch.starts_at = "2016-12-28"
    assert @batch.valid?
  end

  test 'batch is valid when it is yesterday at 11AM UTC' do
    travel_to Time.utc(2016,12,27,11,00,00) # 11AM UTC, 12AM Wellington the next day
    @batch.starts_at = "2016-12-28"
    assert @batch.valid?
  end

  test 'batch is not valid when it is yesterday before 11AM UTC' do
   travel_to Time.utc(2016,12,27,10,59,59) # 11AM UTC, 11:59PM Wellington the same day
   @batch.starts_at = "2016-12-28"
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
