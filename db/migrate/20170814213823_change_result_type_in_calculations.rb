class ChangeResultTypeInCalculations < ActiveRecord::Migration[5.1]
  def change
    change_column :calculations, :result, :float
  end
end
