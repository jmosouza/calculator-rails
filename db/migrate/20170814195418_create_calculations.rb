class CreateCalculations < ActiveRecord::Migration[5.1]
  def change
    create_table :calculations do |t|
      t.integer :left_input, null: false
      t.integer :right_input, null: false
      t.integer :operation, null: false
      t.integer :result
      t.integer :request_count, null: false, default: 0

      t.timestamps
    end
  end
end
