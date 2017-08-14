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

  test "sum operation" do
    assert_equal 5, Calculation.new(
      left_input: 3,
      right_input: 2,
      operation: :sum_op
    ).send(:calculate)
  end

  test "difference operation" do
    assert_equal 1, Calculation.new(
      left_input: 3,
      right_input: 2,
      operation: :difference_op
    ).send(:calculate)
  end

  test "multiplication operation" do
    assert_equal 6, Calculation.new(
      left_input: 3,
      right_input: 2,
      operation: :multiplication_op
    ).send(:calculate)
  end

  test "division operation" do
    assert_equal 1.5, Calculation.new(
      left_input: 3,
      right_input: 2,
      operation: :division_op
    ).send(:calculate)
  end

  test "prevent SQL injection" do
    assert_equal 1, Calculation.new(
      left_input: 'Calculation.all #',
      right_input: 1,
      operation: :sum_op
    ).send(:calculate)
  end

  test "prevent 0/0" do
    c = Calculation.new(
      left_input: 1,
      right_input: 0,
      operation: :division_op
    )
    c.send(:calculate)
    assert_nil c.result
    assert_not_nil c.result_error
  end

  test "prevent 1/0" do
    c = Calculation.new(
      left_input: 1,
      right_input: 0,
      operation: :division_op
    )
    c.send(:calculate)
    assert_nil c.result
    assert_not_nil c.result_error
  end
end
