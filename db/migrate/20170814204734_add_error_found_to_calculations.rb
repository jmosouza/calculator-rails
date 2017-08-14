class AddErrorFoundToCalculations < ActiveRecord::Migration[5.1]
  def change
    add_column :calculations, :result_error, :string
  end
end
