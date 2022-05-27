class RemoveMaxKmFromDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_times, :max_km, :decimal
  end
end
