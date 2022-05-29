class ChangeTotalPriceToDecimalAtWorkOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :work_orders, :total_price, :decimal
  end
end
