class ChangeTypeOfDateAtWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    change_column :work_order_routes, :date, :datetime
  end
end
