class Calculation < ApplicationRecord
  enum operation: [
    :sum_op,
    :difference_op,
    :multiplication_op,
    :division_op
  ]

  validates(
    :result,
    numericality: { only_integer: true },
    if: proc { |c| c.result.present? }
  )

  validates(
    :left_input,
    :right_input,
    :operation,
    :request_count,
    numericality: {
      only_integer: true,
      less_than: 100,
      greater_than_or_equal_to: 0
    }
  )
end
