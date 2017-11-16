require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @roast = roasts(:roast1)
  end

  test 'required batch fields must not be empty' do
    batch = Batch.new
    assert batch.invalid?
    batch.start_date = 5.days.ago
    assert batch.invalid?
    batch.amount_purchased = 22
    assert batch.invalid?
    batch.cost = 2.2
    assert batch.invalid?
  end

  test 'start_date must be earlier (or) today' do
    batch = Batch.new
    batch.amount_purchased = 200
    batch.cost = 22
    batch.roast_id = @roast.id
    batch.start_date = Date.today
    assert batch.valid?
    batch.start_date = 5.days.ago
    assert batch.valid?
  end

  test 'start_date cannot be after today' do
    batch = Batch.new
    batch.amount_purchased = 200
    batch.cost = 22
    batch.roast_id = @roast.id
    batch.start_date = 2.days.from_now
    assert batch.invalid?
  end

  test 'amount_purchased cannot be negative' do
    batch = Batch.new
    batch.amount_purchased = -4
    batch.cost = 22
    batch.roast_id = @roast.id
    batch.start_date = 2.days.ago
    assert batch.invalid?
  end

  test 'cost cannot be negative' do
    batch = Batch.new
    batch.amount_purchased = 22
    batch.cost = -11
    batch.roast_id = @roast.id
    batch.start_date = 2.days.ago
    assert batch.invalid?
  end

  test 'cost can be $0' do
    batch = Batch.new
    batch.amount_purchased = 22
    batch.cost = 0
    batch.roast_id = @roast.id
    batch.start_date = 2.days.ago
    assert batch.valid?
  end

end
