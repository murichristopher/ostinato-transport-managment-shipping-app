class AddKmMaxToDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :km_max, :integer
  end
end
