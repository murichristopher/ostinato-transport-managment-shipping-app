class ChangeFormatOfDateAtWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
      change_column :work_order_routes, :date, :date
  end
end
