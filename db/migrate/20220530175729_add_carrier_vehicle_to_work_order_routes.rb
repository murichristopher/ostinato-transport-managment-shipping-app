class AddCarrierVehicleToWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    add_reference :work_order_routes, :carrier_vehicle, null: true, foreign_key: true
  end
end
