require 'test_helper'

class CalculationsControllerTest < ActionDispatch::IntegrationTest
  test "all operations" do
    Calculation.operations.keys.each do |op|
      post '/calculations', xhr: true, params: {
        left_input: 3,
        right_input: 2,
        operation: op
      }
      assert_response :success
    end
  end

  test 'division by zero' do
    [0, 1].each do |left_input|
      post '/calculations', xhr: true, params: {
        left_input: left_input,
        right_input: 0,
        operation: 'division_op'
      }
      assert_response :success
      assert_equal "error\n", response.body
    end
  end

  test 'invalid input' do
    [-1, 100].each do |left_input|
      post '/calculations', xhr: true, params: {
        left_input: left_input,
        right_input: 1,
        operation: 'division_op'
      }
      assert_response :success
      assert_equal "error\n", response.body
    end
  end

  test 'invalid operation' do
    post '/calculations', xhr: true, params: {
      left_input: 1,
      right_input: 1,
      operation: '*'
    }
    assert_response :success
    assert_equal "error\n", response.body
  end

  test 'calculations are saved to database only once' do
    assert_difference 'Calculation.count', 1 do
      left_input, right_input = (0..99).to_a.sample(2)
      operation = Calculation.operations.keys.sample
      2.times do
        post '/calculations', xhr: true, params: {
          left_input: left_input,
          right_input: right_input,
          operation: operation
        }
      end
    end
  end
end
