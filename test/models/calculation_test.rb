require 'test_helper'

class CalculationTest < ActiveSupport::TestCase
  test "blank calculation is invalid" do
    assert_not Calculation.new.save
  end

  test "inputs must be >= 0" do
    assert_not Calculation.new(
      left_input: -1,
      right_input: -1,
      operation: :sum_op
    ).save
  end

  test "inputs must be < 100" do
    assert_not Calculation.new(
      left_input: 101,
      right_input: 101,
      operation: :sum_op
    ).save
  end
end
