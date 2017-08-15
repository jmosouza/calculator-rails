class CalculationsController < ApplicationController
  def create
    @calculation = Calculation.find_or_initialize_by(calculation_params)
    @calculation.request_count += 1
    @calculation.save
  rescue
    # Do nothing. Errors also need to be rendered by the view.
  end

  private

  def calculation_params
    params.permit(:left_input, :right_input, :operation)
  end
end
