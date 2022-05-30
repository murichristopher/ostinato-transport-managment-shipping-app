class RemoveColumnOfWorkOrder < ActiveRecord::Migration[7.0]
  def change
      remove_column :work_orders, :carrier_vehicle_id, :integer
  end
end
