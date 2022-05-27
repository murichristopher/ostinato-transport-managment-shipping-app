class CreateWorkOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :work_orders do |t|
      t.string :sender_address
      t.string :receiver_address
      t.string :receiver_name
      t.string :receiver_cpf
      t.integer :delivery_time, null: true
      t.integer :total_price
      t.decimal :cubic_size
      t.decimal :total_weight
      t.string :unique_code
      t.references :transport_company, null: true, foreign_key: true

      t.timestamps
    end
  end
end
