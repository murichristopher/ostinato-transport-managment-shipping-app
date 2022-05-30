class AddWorkOrderRuteToCarrierVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :carrier_vehicles, :work_order_route, null: true, foreign_key: true
  end
end
