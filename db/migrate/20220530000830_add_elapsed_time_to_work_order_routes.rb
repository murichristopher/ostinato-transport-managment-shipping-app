class AddElapsedTimeToWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :work_order_routes, :elapseelapsed_time, :integer
  end
end
