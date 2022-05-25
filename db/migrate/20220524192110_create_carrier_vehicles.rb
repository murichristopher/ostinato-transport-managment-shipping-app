class CreateCarrierVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :carrier_vehicles do |t|
      t.string :license_plate
      t.string :brand
      t.string :model
      t.string :year
      t.integer :maximum_load_capacity
      t.references :transport_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
