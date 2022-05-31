class ChangeDistanceToDecimalAtWorkOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :work_orders, :total_distance, :decimal
  end
end
