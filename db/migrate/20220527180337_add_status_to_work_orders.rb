class AddStatusToWorkOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :status, :integer, default: 1
  end
end
