module CalculationsHelper
  # The text interpretation of an operation.
  # e.g. for inputs 24 and 2 in a division, returns "24 ÷ 2".
  def formatted_operation(calculation)
    "#{calculation.left_input} #{formatted_operator(calculation)} #{calculation.right_input}"
  end

  # The "written" symbol corresponding to an operation.
  # Example: division is "÷", not "/".
  def formatted_operator(calculation)
    case calculation.operation.to_sym
    when :sum_op then '+'
    when :difference_op then '-'
    when :multiplication_op then '×'
    when :division_op then '÷'
    end
  end
end
