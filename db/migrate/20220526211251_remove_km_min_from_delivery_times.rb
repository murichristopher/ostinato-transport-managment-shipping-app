class RemoveKmMinFromDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_times, :km_min, :decimal
  end
end
