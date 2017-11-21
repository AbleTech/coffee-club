require 'test_helper'

class RoastTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "required roast fields must not be empty" do
    roast = Roast.new
    assert roast.invalid?
    assert roast.errors[:company].any?
    assert roast.errors[:name].any?
    assert roast.errors[:description].any?
  end

end
