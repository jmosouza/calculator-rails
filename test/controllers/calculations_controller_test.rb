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
end
