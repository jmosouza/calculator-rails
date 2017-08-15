# == Schema Information
#
# Table name: calculations
#
#  id            :integer          not null, primary key
#  left_input    :integer          not null
#  right_input   :integer          not null
#  operation     :integer          not null
#  result        :float
#  request_count :integer          default("0"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  result_error  :string
#

class Calculation < ApplicationRecord
  before_create :calculate

  enum operation: [
    :sum_op,
    :difference_op,
    :multiplication_op,
    :division_op
  ]

  validates(
    :result,
    numericality: true,
    if: proc { |c| c.result.present? }
  )

  validates(
    :left_input,
    :right_input,
    :request_count,
    numericality: {
      only_integer: true,
      less_than: 100,
      greater_than_or_equal_to: 0
    }
  )

  protected

  def calculate
    self.result = eval "#{Float(left_input)} #{operator} #{Integer(right_input)}" # prevent sql injection
    raise "Invalid result: #{result}" if result.nan? || result.infinite?
  rescue => e
    self.result = nil # override previous result
    self.result_error = e
  ensure
    return result
  end

  def operator
    case operation.to_sym
    when :sum_op then '+'
    when :difference_op then '-'
    when :multiplication_op then '*'
    when :division_op then '/'
    end
  end

end
