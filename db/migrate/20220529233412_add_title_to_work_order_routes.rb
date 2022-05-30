class AddTitleToWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :work_order_routes, :title, :string
    add_column :work_order_routes, :description, :string
  end
end
