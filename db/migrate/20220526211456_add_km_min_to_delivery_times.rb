class AddKmMinToDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :km_min, :integer
  end
end
