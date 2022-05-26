class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.decimal :cubic_meters_min
      t.decimal :cubic_meters_max
      t.decimal :weight
      t.decimal :value_per_km
      t.references :transport_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
