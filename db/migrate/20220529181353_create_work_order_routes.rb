class CreateWorkOrderRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :work_order_routes do |t|
      t.date :date
      t.string :last_location
      t.string :next_location
      t.references :work_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
