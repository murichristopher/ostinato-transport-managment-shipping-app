class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.decimal :km_min
      t.decimal :max_km
      t.integer :time
      t.references :transport_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
