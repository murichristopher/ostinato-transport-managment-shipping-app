class AddTitleToWorkOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :work_orders, :title, :string
  end
end
