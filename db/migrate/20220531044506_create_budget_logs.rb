class CreateBudgetLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_logs do |t|
      t.decimal :cubic_size
      t.decimal :total_weight
      t.integer :total_distance
      t.integer :delivery_time
      t.string :total_price
      t.references :transport_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
