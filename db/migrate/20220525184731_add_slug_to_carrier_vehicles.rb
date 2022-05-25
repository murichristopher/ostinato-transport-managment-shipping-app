class AddSlugToCarrierVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :carrier_vehicles, :slug, :string
    add_index :carrier_vehicles, :slug, unique: true
  end
end
