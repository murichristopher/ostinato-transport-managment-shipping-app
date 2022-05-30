class RemoveDescriptionFromWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    remove_column :work_order_routes, :description, :string
  end
end
