class AddWorkOrderToCarrierVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :carrier_vehicles, :work_order, null: true, foreign_key: true
  end
end
