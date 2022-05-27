class AddSlugsToDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :slug, :string
    add_index :delivery_times, :slug, unique: true
  end
end
